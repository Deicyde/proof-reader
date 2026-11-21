// The neighbourhood drawing: one card and what it uses, ranked by how those use one
// another, with every line routed so that none crosses another or runs behind a card.
//
// Ranks are longest paths from the card in view, over the transitive reduction of the
// uses in view (a use that runs through another card in view is drawn once). Each rank
// wraps into rows of equal cards on one column grid, centred, in the order the card's own
// Lean names them; within a rank, cards that use something lower down go in the last row,
// so their lines drop straight into the gap below, and rows fill from the bottom. A line
// into a card runs on its own track in the gap above that card's row; a line that must pass
// a row on its way runs down a gutter between that row's cards. Statement-only uses are
// dashed only when uses of both kinds are drawn; the key under the drawing says which.
// Every drawing checks itself: data-crossings and data-behind count crossing lines and
// lines behind cards.

import { useEffect, useLayoutEffect, useMemo, useRef, useState } from "react";
import type { ArgGraph } from "../model/graph";

const CARD_W = 150;
/** Proof Reader: a wide pane spreads the cards into wider columns, up to this, and up to four of them. */
const CARD_W_MAX = 230;
const MAX_COLS = 4;
/** A drawing that leaves the pane mostly empty is drawn larger, up to this. */
const MAX_SCALE = 1.4;
const COL_GAP = 26;
/** Spacing of lines from different cards that pass one gutter. */
const LANE = 5;
/** Between the wrapped rows of one rank, and between ranks: a wrap must not read as a level. */
const STACK_GAP = 8;
const LEVEL_GAP = 24;
/** The drawing may shrink to fit the pane's height, never below this. */
const MIN_SCALE = 0.82;
const LINE_H = 16;

/** Lines a title wraps to in a card of CARD_W at the card's type size. */
function titleLines(title: string, width = CARD_W): number {
  const perLine = Math.floor((width - 16) / 6.9);
  let lines = 1;
  let used = 0;
  for (const w of title.split(/\s+/)) {
    if (used && used + 1 + w.length > perLine) {
      lines += 1;
      used = w.length;
    } else used += (used ? 1 : 0) + w.length;
  }
  return lines;
}

/** Lines a raw Lean name wraps to, breaking only after a dot. */
/** The last part of a Lean name: `PCP.Verifier.ReadsBelow` is shown as `ReadsBelow`. */
const shortName = (name: string) => name.split(".").pop() ?? name;

function rawLines(name: string, width = CARD_W): number {
  const perLine = Math.max(8, Math.floor((width - 16) / 6.6));
  let lines = 1;
  let used = 0;
  for (const part of name.split(".")) {
    const w = part.length + 1;
    if (used && used + w > perLine) {
      lines += 1;
      used = w;
    } else used += w;
    // A part longer than a line wraps inside itself: the name is never cut.
    while (used > perLine) {
      lines += 1;
      used -= perLine;
    }
  }
  return lines;
}

interface Placed { id: string; x: number; y: number; w: number; h: number; rank: number; row: number }
interface Segment { x1: number; y1: number; x2: number; y2: number; edges: string[]; kind: string }

/** How many times a horizontal segment crosses a vertical one in their interiors. */
function crossCount(lines: Segment[]): number {
  let n = 0;
  const hs = lines.filter((s) => s.y1 === s.y2);
  const vs = lines.filter((s) => s.x1 === s.x2);
  for (const h of hs)
    for (const v of vs) {
      const [x0, x1] = [Math.min(h.x1, h.x2), Math.max(h.x1, h.x2)];
      const [y0, y1] = [Math.min(v.y1, v.y2), Math.max(v.y1, v.y2)];
      if (v.x1 > x0 + 0.5 && v.x1 < x1 - 0.5 && h.y1 > y0 + 0.5 && h.y1 < y1 - 0.5) n += 1;
    }
  return n;
}

/** Drop every edge u→v that another path u→…→v already covers. */
export function reduce(ids: string[], edges: { from: string; to: string }[]): Set<string> {
  const out = new Map<string, string[]>(ids.map((id) => [id, []]));
  for (const e of edges) out.get(e.from)?.push(e.to);
  const reaches = (from: string, to: string, skip: string): boolean => {
    const seen = new Set<string>();
    const stack = (out.get(from) ?? []).filter((n) => n !== skip);
    while (stack.length) {
      const n = stack.pop()!;
      if (n === to) return true;
      if (seen.has(n)) continue;
      seen.add(n);
      stack.push(...(out.get(n) ?? []));
    }
    return false;
  };
  return new Set(edges.filter((e) => !reaches(e.from, e.to, e.to)).map((e) => `${e.from}→${e.to}`));
}

export function NearMap({ graph, heads, plate, kicker = "Main result", alone, lit, selected, onCard, onHover }: {
  graph: ArgGraph;
  /** The card or cards in view, drawn at the top. */
  heads: string[];
  /** The claim's title above the theorem, at the main result. */
  plate: string | null;
  /** Said under a card that stands alone: why nothing is drawn beneath it. */
  alone?: string;
  /** The small line over the claim's title: which of the paper's results this is. */
  kicker?: string;
  lit: readonly string[];
  selected: string | null;
  onCard(id: string): void;
  onHover(id: string | null): void;
}) {
  const frame = useRef<HTMLDivElement>(null);
  const [width, setWidth] = useState(0);
  const [paneH, setPaneH] = useState(0);
  useLayoutEffect(() => {
    const el = frame.current;
    if (!el) return;
    const observer = new ResizeObserver(() => {
      setWidth(el.clientWidth);
      setPaneH(el.clientHeight);
    });
    observer.observe(el);
    setWidth(el.clientWidth);
    setPaneH(el.clientHeight);
    return () => observer.disconnect();
  }, []);
  const [hot, setHot] = useState<string | null>(null);
  // A new card in view starts with nothing pointed at, whatever lies under the pointer now.
  useEffect(() => setHot(null), [graph]);
  // A new card in view is read from its top.
  const headKey = heads.join("|");
  useEffect(() => {
    if (frame.current) frame.current.scrollTop = 0;
  }, [headKey]);

  // Heights the type actually needed, measured once the cards are drawn: a card is never
  // shorter than its text.
  const [needed, setNeeded] = useState<ReadonlyMap<string, number>>(new Map());
  useEffect(() => setNeeded(new Map()), [graph]);
  const layoutAt = useMemo(() => (width: number) => {
    const ids = graph.order.filter((id) => graph.nodes.has(id) && graph.nodes.get(id)!.kind !== "goal");
    const all = graph.edges.filter((e) => e.kind !== "formalizes" && ids.includes(e.from) && ids.includes(e.to));
    const keep = reduce(ids, all);
    const edges = all.filter((e) => keep.has(`${e.from}→${e.to}`));
    // Longest path from the heads.
    const rank = new Map<string, number>(heads.map((h) => [h, 0]));
    for (let pass = 0; pass < ids.length; pass++)
      for (const e of edges) if (rank.has(e.from) && (rank.get(e.to) ?? -1) < rank.get(e.from)! + 1) rank.set(e.to, rank.get(e.from)! + 1);
    for (const id of ids) if (!rank.has(id)) rank.set(id, 1);
    const depth = Math.max(0, ...rank.values());
    const order = new Map(ids.map((id, i) => [id, i]));
    // Room on each side for the outer gutters, then three columns where the pane allows.
    // Proof Reader: as many columns as the widest level needs, up to four, each as wide as the
    // pane allows, so that a wide pane is used rather than left empty around a thin strip.
    const usable = width - 2 * COL_GAP - 8;
    const widest = Math.max(1, ...[...new Set(rank.values())].map((r) => ids.filter((id) => rank.get(id) === r).length));
    const fitCols = Math.max(1, Math.floor((usable + COL_GAP) / (CARD_W + COL_GAP)));
    const cols = Math.max(1, Math.min(MAX_COLS, fitCols, Math.max(3, widest)));
    const cardW = Math.max(120, Math.min(CARD_W_MAX, Math.floor((usable + COL_GAP) / cols) - COL_GAP));
    // A card: its plain title, and the last part of its Lean name (the whole name on hover).
    const cardH = (id: string) => Math.max(needed.get(id) ?? 0, 16 + titleLines(graph.nodes.get(id)?.label ?? id, cardW) * LINE_H + rawLines(shortName(graph.nodes.get(id)?.rawName ?? id), cardW) * 13);
    // Columns, from the bottom level up. The deepest level spreads across the columns in the
    // Lean's order; each level above stands in columns over what it uses: a card takes the
    // column at the barycentre of its uses in the level below (half-way rounds right), cards
    // using nothing below fill the shortest columns in the Lean's order. Within a column the
    // cards with no lines come first, then the cards whose uses are all under them, then the
    // ones that also use something under another column.
    const levels: string[][] = [];
    for (let r = 0; r <= depth; r++) levels.push(ids.filter((id) => rank.get(id) === r).sort((a, b) => order.get(a)! - order.get(b)!));
    const colOf = new Map<string, number>();
    const stacks: Map<number, string[]>[] = [];
    const below = (u: string) => edges.filter((e) => e.from === u && rank.get(e.to) === rank.get(u)! + 1).map((e) => e.to);
    for (let r = depth; r >= 0; r--) {
      const level = levels[r];
      const stack = new Map<number, string[]>();
      const put = (id: string, c: number) => {
        colOf.set(id, c);
        stack.set(c, [...(stack.get(c) ?? []), id]);
      };
      const users = level.filter((u) => below(u).length);
      const fillers = level.filter((u) => !below(u).length);
      if (!users.length) {
        // Nothing below to stand over: spread across the middle columns in order.
        const n = Math.min(cols, level.length);
        const start = Math.floor((cols - n) / 2);
        level.forEach((id, i) => put(id, start + (i % n)));
      } else {
        for (const u of users) {
          const cs = below(u).map((t) => colOf.get(t)!);
          put(u, Math.min(cols - 1, Math.round(cs.reduce((a, b) => a + b, 0) / cs.length)));
        }
        for (const f of fillers) {
          let best = 0;
          for (let c = 1; c < cols; c++) if ((stack.get(c)?.length ?? 0) < (stack.get(best)?.length ?? 0)) best = c;
          put(f, best);
        }
        for (const [c, list] of stack) {
          const kind = (id: string) => (!below(id).length ? 0 : below(id).every((t) => colOf.get(t) === c) ? 1 : 2);
          list.sort((a, b) => kind(a) - kind(b) || order.get(a)! - order.get(b)!);
        }
      }
      stacks[r] = stack;
    }
    // Geometry: one column grid, centred.
    const gridW = cols * cardW + (cols - 1) * COL_GAP;
    const left0 = (width - gridW) / 2;
    const colX = (c: number) => left0 + c * (cardW + COL_GAP);
    const xOf = new Map<string, number>();
    const placed = new Map<string, Placed>();
    const rows: { y: number; h: number; ids: string[]; rank: number }[] = [];
    // A card that uses every card of a wrapped level just below it draws one line to that
    // level's band; the band's label says what the line means.
    const bandOf = new Map<number, string>();
    for (let r = 1; r <= depth; r++) {
      const height = Math.max(0, ...[...(stacks[r]?.values() ?? [])].map((l) => l.length));
      if (height < 2 && levels[r].length <= cols) continue;
      const owner = levels[r - 1].find((q) => levels[r].every((m) => edges.some((e) => e.from === q && e.to === m)));
      if (owner) bandOf.set(r, owner);
    }
    let y = plate ? 74 : 12;
    for (let r = 0; r <= depth; r++) {
      const stack = stacks[r];
      if (!stack || !stack.size) continue;
      if (r > 0) y += LEVEL_GAP + (bandOf.has(r) ? 18 : 0);
      const height = Math.max(...[...stack.values()].map((l) => l.length));
      for (let i = 0; i < height; i++) {
        const here = [...stack.entries()].filter(([, l]) => l[i]).map(([c, l]) => [c, l[i]] as const);
        const h = Math.max(...here.map(([, id]) => cardH(id)));
        if (i > 0) y += STACK_GAP;
        // A level that fits in one row and stands over nothing is centred as a row.
        const single = height === 1 && r === 0;
        here.forEach(([c, id], k) => {
          const x = single ? (width - (here.length * cardW + (here.length - 1) * COL_GAP)) / 2 + k * (cardW + COL_GAP) : colX(c);
          xOf.set(id, x);
          placed.set(id, { id, x, y, w: cardW, h, rank: r, row: rows.length });
        });
        rows.push({ y, h, ids: here.map(([, id]) => id), rank: r });
        y += h;
      }
    }
    // Lines. One trunk per card that is used from the level above, in the gutter to the right
    // of its column, from its highest user down to just above it; each user joins it with a
    // short stub from its nearer side. A user under another column reaches the trunk along the
    // gap above the target's level.
    const segments: Segment[] = [];
    const add = (x1: number, y1: number, x2: number, y2: number, label: string, kind: string) => segments.push({ x1, y1, x2, y2, edges: [label], kind });
    const lanes = new Map<number, number>();
    for (const [r, owner] of bandOf) {
      const o = placed.get(owner)!;
      const first = rows.find((x) => x.rank === r)!;
      const names = levels[r].map((m) => `${owner}→${m}`).join(" ");
      add(o.x + cardW / 2, o.y + o.h, o.x + cardW / 2, first.y - 26, names, edges.find((e) => e.from === owner)?.kind ?? "supports");
    }
    const covered = (e: (typeof edges)[number]) => bandOf.get(rank.get(e.to)!) === e.from;
    const targets = [...new Set(edges.filter((e) => !covered(e)).map((e) => e.to))];
    for (const t of targets) {
      const tp = placed.get(t)!;
      const ins = edges.filter((e) => e.to === t && !covered(e));
      const c = colOf.get(t)!;
      const gutter = colX(c) + cardW + COL_GAP / 2;
      const used = lanes.get(c) ?? 0;
      lanes.set(c, used + 1);
      const tx = gutter + (used ? (used % 2 ? 1 : -1) * Math.ceil(used / 2) * LANE : 0);
      const turn = tp.y - 9;
      const port = tp.x + cardW - 18;
      const label = ins.map((e) => `${e.from}→${t}`).join(" ");
      const kind = ins[0]?.kind ?? "supports";
      let top = turn;
      for (const e of ins) {
        const up = placed.get(e.from)!;
        const ucol = colOf.get(e.from)!;
        const mid = up.y + Math.min(up.h / 2, 18);
        if (ucol === c) {
          add(up.x + cardW, mid, tx, mid, `${e.from}→${t}`, e.kind);
          top = Math.min(top, mid);
        } else if (ucol === c + 1) {
          add(up.x, mid, tx, mid, `${e.from}→${t}`, e.kind);
          top = Math.min(top, mid);
        } else {
          // Farther away: down its own right gutter to the gap above the target, then across.
          const ux = colX(ucol) + cardW + COL_GAP / 2 + LANE;
          const gy = turn - 6;
          add(up.x + cardW, mid, ux, mid, `${e.from}→${t}`, e.kind);
          add(ux, mid, ux, gy, `${e.from}→${t}`, e.kind);
          add(Math.min(ux, tx), gy, Math.max(ux, tx), gy, `${e.from}→${t}`, e.kind);
          top = Math.min(top, gy);
        }
      }
      add(tx, top, tx, turn, label, kind);
      add(port, turn, tx, turn, label, kind);
      add(port, turn, port, tp.y, label, kind);
    }
    // Merge identical segments (drawn once).
    const seen = new Map<string, Segment>();
    for (const s of segments) {
      const k = `${s.x1.toFixed(1)},${s.y1.toFixed(1)},${s.x2.toFixed(1)},${s.y2.toFixed(1)}`;
      if (seen.has(k)) seen.get(k)!.edges.push(...s.edges);
      else seen.set(k, s);
    }
    const lines = [...seen.values()];
    const crossings = crossCount(lines);
    let behind = 0;
    for (const s of lines)
      for (const p of placed.values()) {
        const [x0, x1] = [Math.min(s.x1, s.x2), Math.max(s.x1, s.x2)];
        const [y0, y1] = [Math.min(s.y1, s.y2), Math.max(s.y1, s.y2)];
        if (x1 > p.x + 0.5 && x0 < p.x + p.w - 0.5 && y1 > p.y + 0.5 && y0 < p.y + p.h - 0.5) behind += 1;
      }
    const kinds = new Set(edges.map((e) => e.kind));
    const bands = [...new Set(rows.map((r) => r.rank))].flatMap((r) => {
      const these = rows.filter((x) => x.rank === r);
      if (these.length < 2) return [];
      const xs = these.flatMap((x) => x.ids.map((id) => xOf.get(id)!));
      const owner = bandOf.get(r);
      // A labelled band has room at its top for the label, where the owner's line ends.
      const top = these[0].y - (owner ? 22 : 6);
      return [{ x: Math.min(...xs) - 8, y: top, w: Math.max(...xs) + cardW - Math.min(...xs) + 16, h: these[these.length - 1].y + these[these.length - 1].h - top + 6,
        label: owner ? `Everything on this band is used by ${graph.nodes.get(owner)?.label ?? owner}` : null }];
    });
    return { placed, lines, width, height: y + 12, crossings, behind, kinds, edges, bands };
  }, [graph, heads, plate, needed]);
  // Shrink to fit the pane with the one-line key under the drawing; past MIN_SCALE it scrolls.
  // A small drawing in a large pane is laid out narrower and drawn larger, to use the room.
  const KEY_H = 34;
  const drawing = useMemo(() => {
    if (!width) return null;
    const first = layoutAt(width);
    if (!paneH) return first;
    const up = Math.min(MAX_SCALE, (paneH - KEY_H) / first.height, width / 300);
    return up > 1.05 ? layoutAt(width / up) : first;
  }, [layoutAt, width, paneH]);

  // Above the Lean, the graph takes only the room its drawing needs, up to the share the
  // reader has given it: a card with two uses leaves the rest of the page to its Lean.
  const tail = useRef<HTMLParagraphElement>(null);
  useLayoutEffect(() => {
    const el = frame.current;
    const pane = el?.closest<HTMLElement>(".proof__graph");
    const panes = el?.closest<HTMLElement>(".proof__panes");
    if (!el || !pane || !panes || !drawing) return;
    const above = el.getBoundingClientRect().top - pane.getBoundingClientRect().top;
    panes.style.setProperty("--graph-want", `${Math.ceil(above + drawing.height + (tail.current?.offsetHeight ?? 0) + 14)}px`);
  }, [drawing, alone]);
  useEffect(() => {
    const panes = frame.current?.closest<HTMLElement>(".proof__panes");
    return () => {
      panes?.style.removeProperty("--graph-want");
    };
  }, []);
  const fit = drawing && paneH ? Math.max(MIN_SCALE, Math.min(MAX_SCALE, width / drawing.width, (paneH - KEY_H) / drawing.height)) : 1;
  // Once drawn, any card whose text needs more room than estimated is laid out again taller.
  useLayoutEffect(() => {
    const world = frame.current?.querySelector<HTMLElement>(".nearmap__world");
    if (!world) return;
    const grow = new Map<string, number>();
    world.querySelectorAll<HTMLElement>(".nearmap__card").forEach((card) => {
      const over = card.scrollHeight - card.clientHeight;
      if (over > 1) grow.set(card.dataset.record!, card.offsetHeight + over + 2);
    });
    if (grow.size) setNeeded((was) => new Map([...was, ...grow]));
  }, [drawing]);
  const near = (id: string) => !!hot && (id === hot || !!drawing?.edges.some((e) => (e.from === hot && e.to === id) || (e.to === hot && e.from === id)));
  const point = (id: string | null) => {
    setHot(id);
    onHover(id);
  };
  return (
    <div className="nearmap" ref={frame} data-hot={hot ?? undefined}>
      {drawing && (
        <div className="nearmap__fit" style={{ height: drawing.height * fit }}>
        <div key={headKey} className="nearmap__world" style={{ width: drawing.width, height: drawing.height, left: (width - drawing.width * fit) / 2, transformOrigin: "0 0", transform: fit !== 1 ? `scale(${fit})` : undefined }} data-crossings={drawing.crossings} data-behind={drawing.behind} data-scale={fit.toFixed(2)}>
          {plate && (
            <div className="nearmap__plate">
              <span className="nearmap__kicker">{kicker}</span>
              <span className="nearmap__claim">{plate}</span>
            </div>
          )}
          <svg className="nearmap__lines" width={drawing.width} height={drawing.height} aria-hidden="true">
            {drawing.bands.map((b, i) => <rect key={`band${i}`} className="nearmap__band" x={b.x} y={b.y} width={b.w} height={b.h} rx={8} />)}
            {drawing.bands.map((b, i) => b.label && <text key={`bandlabel${i}`} className="nearmap__bandlabel" x={b.x + 10} y={b.y + 13}>{b.label}</text>)}
            {drawing.lines.map((s, i) => (
              <line
                key={i}
                x1={s.x1}
                y1={s.y1}
                x2={s.x2}
                y2={s.y2}
                className={`nearmap__line${drawing.kinds.size > 1 && s.kind === "lean_type_dependency" ? " nearmap__line--statement" : ""}${hot && s.edges.some((e) => e.split("→").includes(hot)) ? " is-hot" : ""}`}
              />
            ))}
          </svg>
          {[...drawing.placed.values()].map((p) => {
            const node = graph.nodes.get(p.id);
            return (
              <button
                key={p.id}
                type="button"
                className={`nearmap__card${heads.includes(p.id) ? " is-head" : ""}${lit.includes(p.id) ? " is-lit" : ""}${selected === p.id ? " is-selected" : ""}${near(p.id) ? " is-near" : ""}`}
                data-record={p.id}
                data-shape={node?.shape}
                style={{ left: p.x, top: p.y, width: p.w, height: p.h }}
                onClick={() => onCard(p.id)}
                onMouseEnter={() => point(p.id)}
                onMouseLeave={() => point(null)}
                onFocus={() => point(p.id)}
                onBlur={() => point(null)}
              >
                <span className="nearmap__title">{node?.label ?? p.id}</span>
                <code className="nearmap__raw" title={node?.rawName ?? p.id}>{shortName(node?.rawName ?? p.id)}</code>
              </button>
            );
          })}
        </div>
        </div>
      )}
      {drawing && drawing.edges.length === 0 && alone && <p className="nearmap__alone" ref={tail}>{alone}</p>}
      {drawing && drawing.edges.length > 0 && (
        <p className="nearmap__key" ref={tail}>
          <span>
            {drawing.kinds.size > 1
              ? "Lines run down to what a card uses; dashed: its statement only."
              : "Each line runs down from a card to a declaration it uses."}
          </span>
          <span className="nearmap__shapes"><i className="key-shape key-shape--theorem" aria-hidden="true" />theorem<i className="key-shape" aria-hidden="true" />definition</span>
        </p>
      )}
    </div>
  );
}
