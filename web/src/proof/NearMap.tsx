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

import { useLayoutEffect, useMemo, useRef, useState } from "react";
import type { ArgGraph } from "../model/graph";

const CARD_W = 150;
const COL_GAP = 14;
/** Between the wrapped rows of one rank, and between ranks: a wrap must not read as a level. */
const ROW_GAP = 18;
const RANK_GAP = 44;
const LINE_H = 16;

/** Lines a title wraps to in a card of CARD_W at the card's type size. */
function titleLines(title: string): number {
  const perLine = Math.floor((CARD_W - 16) / 6.9);
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
function rawLines(name: string): number {
  const perLine = Math.floor((CARD_W - 16) / 6.6);
  let lines = 1;
  let used = 0;
  for (const part of name.split(".")) {
    const w = part.length + 1;
    if (used && used + w > perLine) {
      lines += 1;
      used = w;
    } else used += w;
  }
  return lines;
}

interface Placed { id: string; x: number; y: number; w: number; h: number; rank: number; row: number }
interface Segment { x1: number; y1: number; x2: number; y2: number; edges: string[]; kind: string }

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

export function NearMap({ graph, heads, plate, lit, selected, onCard, onHover }: {
  graph: ArgGraph;
  /** The card or cards in view, drawn at the top. */
  heads: string[];
  /** The claim's title above the theorem, at the main result. */
  plate: string | null;
  lit: readonly string[];
  selected: string | null;
  onCard(id: string): void;
  onHover(id: string | null): void;
}) {
  const frame = useRef<HTMLDivElement>(null);
  const [width, setWidth] = useState(0);
  useLayoutEffect(() => {
    const el = frame.current;
    if (!el) return;
    const observer = new ResizeObserver(() => setWidth(el.clientWidth));
    observer.observe(el);
    setWidth(el.clientWidth);
    return () => observer.disconnect();
  }, []);
  const [hot, setHot] = useState<string | null>(null);

  const drawing = useMemo(() => {
    if (!width) return null;
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
    const hasLower = (id: string) => edges.some((e) => e.from === id);
    const cols = Math.max(1, Math.floor((width - 24 + COL_GAP) / (CARD_W + COL_GAP)));
    const placed = new Map<string, Placed>();
    // Rows: each rank wraps on a column grid. Cards that use something lower go in the
    // rank's last row, so their lines drop straight down; the rows fill from the bottom.
    const rowsPlan: { ids: string[]; rank: number }[] = [];
    const cardH = (id: string) => 22 + titleLines(graph.nodes.get(id)?.label ?? id) * LINE_H + rawLines(graph.nodes.get(id)?.rawName ?? id) * 13;
    const slot = new Map<string, number>();
    for (let r = 0; r <= depth; r++) {
      const members = ids.filter((id) => rank.get(id) === r);
      if (!members.length) continue;
      // Within a rank: under the cards that use them, in the order of the Lean.
      const meanParent = (id: string) => {
        const ps = edges.filter((e) => e.to === id && slot.has(e.from)).map((e) => slot.get(e.from)!);
        return ps.length ? ps.reduce((a, b) => a + b, 0) / ps.length : 0;
      };
      const plain = members.filter((id) => !hasLower(id)).sort((a, b) => order.get(a)! - order.get(b)!);
      const users = members.filter(hasLower).sort((a, b) => meanParent(a) - meanParent(b) || order.get(a)! - order.get(b)!);
      const line = [...plain, ...users];
      const count = Math.ceil(line.length / cols);
      const first = line.length - (count - 1) * cols;
      for (let k = 0, start = 0; k < count; k++) {
        const n = k === 0 ? first : cols;
        const row = line.slice(start, start + n);
        row.forEach((id, i) => slot.set(id, rowsPlan.length * 100 + i - (row.length - 1) / 2));
        rowsPlan.push({ ids: row, rank: r });
        start += n;
      }
    }
    const rowOf = new Map<string, number>();
    rowsPlan.forEach((row, ri) => row.ids.forEach((id) => rowOf.set(id, ri)));
    const xOf = new Map<string, number>();
    rowsPlan.forEach((row) => {
      const rowW = row.ids.length * CARD_W + (row.ids.length - 1) * COL_GAP;
      row.ids.forEach((id, i) => xOf.set(id, (width - rowW) / 2 + i * (CARD_W + COL_GAP)));
    });
    const cx = (id: string) => xOf.get(id)! + CARD_W / 2;

    // Groups of lines in each gap (gap g lies above row g): each card that uses something
    // lower has one channel per gap it reaches, from its own row down to its last child's
    // row. Only lines from one card share a channel; a card fed by several has one port on
    // its top edge for each, in the order of the cards feeding it.
    interface Group { key: string; gap: number; parent: string | null; child: string | null; edges: typeof edges; xs: number[]; trunk: boolean; continues: boolean; y: number }
    const groups = new Map<string, Group>();
    const group = (key: string, gap: number, init: Partial<Group>) => {
      if (!groups.has(key)) groups.set(key, { key, gap, parent: null, child: null, edges: [], xs: [], trunk: false, continues: false, y: 0, ...init });
      return groups.get(key)!;
    };
    const portX = (e: (typeof edges)[number]) => {
      const ins = edges.filter((x) => x.to === e.to).sort((a, b) => cx(a.from) - cx(b.from));
      return xOf.get(e.to)! + (CARD_W * (ins.indexOf(e) + 1)) / (ins.length + 1);
    };
    for (const p of ids) {
      const outs = edges.filter((e) => e.from === p);
      if (!outs.length) continue;
      const last = Math.max(...outs.map((e) => rowOf.get(e.to)!));
      for (let gap = rowOf.get(p)! + 1; gap <= last; gap++) {
        const g = group(`out:${p}:${gap}`, gap, { parent: p, trunk: gap > rowOf.get(p)! + 1, continues: gap < last });
        for (const e of outs.filter((x) => rowOf.get(x.to) === gap)) {
          g.edges.push(e);
          g.xs.push(portX(e));
        }
        if (gap === rowOf.get(p)! + 1) g.xs.push(cx(p));
      }
    }
    // Where a parent's line passes a row: the gutter of that row nearest where it is.
    const gutterNear = (ri: number, x: number) => {
      const xs = rowsPlan[ri].ids.map((id) => xOf.get(id)!);
      const options = [xs[0] - COL_GAP / 2, ...xs.map((v) => v + CARD_W + COL_GAP / 2)];
      return options.reduce((best, v) => (Math.abs(v - x) < Math.abs(best - x) ? v : best), options[0]);
    };
    const trunkX = new Map<string, number>();
    for (const g of [...groups.values()].sort((a, b) => a.gap - b.gap))
      if (g.trunk && g.parent) {
        const prev = groups.get(`out:${g.parent}:${g.gap - 1}`)!;
        const from = trunkX.get(prev.key) ?? cx(g.parent);
        const x = gutterNear(g.gap - 1, from);
        trunkX.set(g.key, x);
        prev.xs.push(x);
        g.xs.push(x);
      }
    // Tracks in each gap: lines coming down a trunk on top, lines going on to lower rows at
    // the bottom, the rest nested by their spans so that no vertical crosses a horizontal.
    const gapHeights: number[] = [];
    for (let gap = 1; gap < rowsPlan.length; gap++) {
      const here = [...groups.values()].filter((g) => g.gap === gap);
      here.sort((a, b) => Number(b.trunk) - Number(a.trunk) || Number(a.continues) - Number(b.continues) || (Math.min(...a.xs) - Math.min(...b.xs)) || (Math.max(...b.xs) - Math.max(...a.xs)));
      here.forEach((g, i) => (g.y = i));
      gapHeights[gap] = Math.max(rowsPlan[gap].rank !== rowsPlan[gap - 1].rank ? RANK_GAP : ROW_GAP, (here.length + 1) * 10);
    }
    // Vertical placement.
    const rows: { y: number; h: number; ids: string[]; rank: number }[] = [];
    let y = plate ? 78 : 14;
    rowsPlan.forEach((row, ri) => {
      if (ri > 0) y += gapHeights[ri];
      const h = Math.max(...row.ids.map(cardH));
      row.ids.forEach((id) => placed.set(id, { id, x: xOf.get(id)!, y, w: CARD_W, h, rank: row.rank, row: ri }));
      rows.push({ y, h, ids: row.ids, rank: row.rank });
      y += h;
    });
    const trackY = (g: Group) => {
      const top = rows[g.gap - 1].y + rows[g.gap - 1].h;
      const n = [...groups.values()].filter((x) => x.gap === g.gap).length;
      return top + ((rows[g.gap].y - top) * (g.y + 1)) / (n + 1);
    };
    const segments: Segment[] = [];
    const add = (x1: number, y1: number, x2: number, y2: number, edge: string, kind: string) => segments.push({ x1, y1, x2, y2, edges: [edge], kind });
    for (const g of groups.values()) {
      const ty = trackY(g);
      const kind = g.edges[0]?.kind ?? edges.find((e) => e.from === g.parent)?.kind ?? "supports";
      const names = g.edges.map((e) => `${e.from}→${e.to}`);
      const label = names.length ? names.join(" ") : edges.filter((e) => e.from === g.parent).map((e) => `${e.from}→${e.to}`).join(" ");
      if (g.xs.length > 1) add(Math.min(...g.xs), ty, Math.max(...g.xs), ty, label, kind);
      for (const e of g.edges) add(portX(e), ty, portX(e), placed.get(e.to)!.y, `${e.from}→${e.to}`, e.kind);
      if (g.parent && !g.trunk) add(cx(g.parent), placed.get(g.parent)!.y + placed.get(g.parent)!.h, cx(g.parent), ty, label, kind);
      if (g.parent && g.trunk) {
        const prev = groups.get(`out:${g.parent}:${g.gap - 1}`)!;
        const x = trunkX.get(g.key)!;
        add(x, trackY(prev), x, ty, label, kind);
      }
    }
    // Merge identical segments (drawn once).
    const seen = new Map<string, Segment>();
    for (const s of segments) {
      const k = `${s.x1.toFixed(1)},${s.y1.toFixed(1)},${s.x2.toFixed(1)},${s.y2.toFixed(1)}`;
      if (seen.has(k)) seen.get(k)!.edges.push(...s.edges);
      else seen.set(k, s);
    }
    const lines = [...seen.values()];
    // Self-check, kept on the drawing for tests: crossings between lines of different
    // groups, and lines passing behind a card.
    let crossings = 0;
    const hs = lines.filter((s) => s.y1 === s.y2);
    const vs = lines.filter((s) => s.x1 === s.x2);
    for (const h of hs)
      for (const v of vs) {
        const [x0, x1] = [Math.min(h.x1, h.x2), Math.max(h.x1, h.x2)];
        const [y0, y1] = [Math.min(v.y1, v.y2), Math.max(v.y1, v.y2)];
        if (v.x1 > x0 + 0.5 && v.x1 < x1 - 0.5 && h.y1 > y0 + 0.5 && h.y1 < y1 - 0.5) crossings += 1;
      }
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
      return [{ x: Math.min(...xs) - 8, y: these[0].y - 6, w: Math.max(...xs) + CARD_W - Math.min(...xs) + 16, h: these[these.length - 1].y + these[these.length - 1].h - these[0].y + 12 }];
    });
    return { placed, lines, height: y + 24, crossings, behind, kinds, edges, bands };
  }, [graph, heads, plate, width]);

  const near = (id: string) => !!hot && (id === hot || !!drawing?.edges.some((e) => (e.from === hot && e.to === id) || (e.to === hot && e.from === id)));
  const point = (id: string | null) => {
    setHot(id);
    onHover(id);
  };
  return (
    <div className="nearmap" ref={frame} data-hot={hot ?? undefined}>
      {drawing && (
        <div className="nearmap__world" style={{ height: drawing.height }} data-crossings={drawing.crossings} data-behind={drawing.behind}>
          {plate && (
            <div className="nearmap__plate">
              <span className="nearmap__kicker">Main result</span>
              <span className="nearmap__claim">{plate}</span>
            </div>
          )}
          <svg className="nearmap__lines" width={width} height={drawing.height} aria-hidden="true">
            {drawing.bands.map((b, i) => <rect key={`band${i}`} className="nearmap__band" x={b.x} y={b.y} width={b.w} height={b.h} rx={8} />)}
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
                <code className="nearmap__raw">{(node?.rawName ?? p.id).split(".").map((part, i, all) => <span key={i}>{part}{i < all.length - 1 && <>.<wbr /></>}</span>)}</code>
              </button>
            );
          })}
        </div>
      )}
      {drawing && (
        <p className="nearmap__key">
          {drawing.kinds.size > 1
            ? "Lines run down to what a card uses; dashed: its statement only."
            : "Each line runs down from a card to a declaration it uses."}
        </p>
      )}
    </div>
  );
}
