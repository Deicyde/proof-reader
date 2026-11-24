// The dependency map of Physlib's API maps: which maps this one cites, which cite it, and how
// all of them connect. The cards and connectors come from the reader's own map engine
// (map/engine): the layered layout places a citing map above the maps it cites, and the router
// draws the connectors, so each card's citations join one line into its bottom edge. Two maps that
// cite each other are one line with an arrowhead at each end. Every card opens that map on
// physlib.io, the same address the tracker's own map uses.

import { useLayoutEffect, useMemo, useRef, useState } from "react";
import { layoutTree } from "../map/engine/layout";
import { transitiveReduction } from "../map/engine/skeleton";
import { polygonPath, roundedPath, route, type Pt } from "../map/engine/router";
import { METRICS_COMPACT, type EngineEdge, type Rect } from "../map/engine/types";

export interface MapNode {
  path: string;
  title: string;
  done: number;
  total: number;
  cites: string[];
}

const ROOT = "∅top";
const CARD = { w: 232, h: 92 };
const METRICS = { ...METRICS_COMPACT, sepCard: 28, gapMin: 58 };

/** The maps reachable from `start` along `next`, without `start` itself. */
function reach(start: string, next: (path: string) => string[]): Set<string> {
  const seen = new Set<string>();
  const stack = [...next(start)];
  while (stack.length) {
    const id = stack.pop()!;
    if (id === start || seen.has(id)) continue;
    seen.add(id);
    stack.push(...next(id));
  }
  return seen;
}

export interface DepGraph {
  nodes: string[];
  edges: EngineEdge[];
  /** Keys of drawn edges whose two maps cite each other. */
  mutual: Set<string>;
  /** Citations left out to make the drawing acyclic that are not one side of a mutual pair. */
  dropped: EngineEdge[];
  /** Citations not drawn because a longer drawn chain of citations joins the same two maps. */
  implied: EngineEdge[];
}

/** The shown maps split into groups joined by citations, largest first, and the maps with no citation either way. */
export function citationGroups(maps: readonly MapNode[], shown: ReadonlySet<string>): { groups: Set<string>[]; alone: string[] } {
  const link = new Map<string, Set<string>>();
  for (const p of shown) link.set(p, new Set());
  for (const m of maps) {
    if (!shown.has(m.path)) continue;
    for (const c of m.cites) if (shown.has(c) && c !== m.path) { link.get(m.path)!.add(c); link.get(c)!.add(m.path); }
  }
  const seen = new Set<string>();
  const groups: Set<string>[] = [];
  const alone: string[] = [];
  for (const p of shown) {
    if (seen.has(p)) continue;
    const group = new Set([p, ...reach(p, (q) => [...link.get(q)!])]);
    for (const q of group) seen.add(q);
    if (group.size === 1) alone.push(p);
    else groups.push(group);
  }
  groups.sort((a, b) => b.size - a.size);
  return { groups, alone };
}

/**
 * The drawn graph for a set of maps: an edge from each citing map to each map it cites, a hidden
 * root above every map that no shown map cites, and each cycle broken by leaving out the edge a
 * depth-first walk from the root meets last. Every cycle in Physlib's maps is a pair of maps that
 * cite each other, so the edge kept for the pair is drawn with a head at each end.
 */
export function dependencyGraph(maps: readonly MapNode[], shown: ReadonlySet<string>): DepGraph {
  const byPath = new Map(maps.map((m) => [m.path, m]));
  const title = (p: string) => byPath.get(p)?.title ?? p;
  const cites = (p: string) => (byPath.get(p)?.cites ?? []).filter((c) => shown.has(c) && c !== p).sort((a, b) => title(a).localeCompare(title(b)));
  const nodes = [...shown].sort((a, b) => title(a).localeCompare(title(b)));
  const citedByShown = new Set(nodes.flatMap(cites));
  const tops = nodes.filter((p) => !citedByShown.has(p));
  const state = new Map<string, 1 | 2>();
  const kept: EngineEdge[] = [];
  const back: EngineEdge[] = [];
  const visit = (p: string) => {
    state.set(p, 1);
    for (const c of cites(p)) {
      const e: EngineEdge = { key: `${p}→${c}`, from: p, to: c, kind: "supports" };
      if (state.get(c) === 1) back.push(e);
      else {
        kept.push(e);
        if (!state.has(c)) visit(c);
      }
    }
    state.set(p, 2);
  };
  // Start from the maps nobody cites; a set that is one big cycle starts from its first map.
  for (const p of [...tops, ...nodes]) if (!state.has(p)) visit(p);
  const keys = new Set(kept.map((e) => e.key));
  const mutual = new Set<string>();
  const dropped: EngineEdge[] = [];
  for (const e of back) {
    const reverse = `${e.to}→${e.from}`;
    if (keys.has(reverse)) mutual.add(reverse);
    else dropped.push(e);
  }
  // A citation that a longer chain of citations already implies is left out of the drawing, as the
  // argument map leaves out implied support (engine/skeleton.ts). A mutual pair is always drawn.
  const typed = kept.map((e): EngineEdge => (mutual.has(e.key) ? { ...e, kind: "assumes" } : e));
  const skeleton = transitiveReduction(nodes, typed);
  const drawn = skeleton.edges;
  const implied = kept.filter((e) => skeleton.implied.has(e.key));
  const hasParent = new Set(drawn.map((e) => e.to));
  const rootEdges = nodes.filter((p) => !hasParent.has(p)).map((p): EngineEdge => ({ key: `${ROOT}→${p}`, from: ROOT, to: p, kind: "supports" }));
  return { nodes: [ROOT, ...nodes], edges: [...rootEdges, ...drawn], mutual, dropped, implied };
}

function claims(m: MapNode): string {
  if (!m.total) return "No claims listed";
  if (m.done === m.total) return `All ${m.total} claims formalized`;
  return `${m.done}/${m.total} claims formalized`;
}

/** A downward arrowhead whose tip touches the top of the cited map. */
function headDown(tip: Pt, length: number): Pt[] {
  const s = length * Math.tan((20 * Math.PI) / 180);
  return [{ x: tip.x - s, y: tip.y - length }, tip, { x: tip.x + s, y: tip.y - length }];
}

/**
 * Ranks counted from the bottom: a map that cites no shown map is on the lowest row, and every other
 * map sits one row above the highest map it cites. The hidden root is row 0, above everything.
 */
export function bottomUp(graph: DepGraph): Map<string, number> {
  const out = new Map<string, string[]>();
  for (const id of graph.nodes) out.set(id, []);
  for (const e of graph.edges) if (e.from !== ROOT) out.get(e.from)!.push(e.to);
  const height = new Map<string, number>();
  const visit = (id: string): number => {
    const known = height.get(id);
    if (known !== undefined) return known;
    height.set(id, 0); // acyclic, so this placeholder is never read back
    const h = Math.max(-1, ...out.get(id)!.map(visit)) + 1;
    height.set(id, h);
    return h;
  };
  const real = graph.nodes.filter((id) => id !== ROOT);
  const top = Math.max(0, ...real.map(visit));
  const rank = new Map<string, number>([[ROOT, 0]]);
  for (const id of real) rank.set(id, top - height.get(id)! + 1);
  return rank;
}

interface Drawn {
  key: string;
  cards: { id: string; rect: Rect }[];
  lines: { key: string; from: string; to: string; d: string; heads: string[]; mutual: boolean }[];
  stems: { parent: string; d: string; head: string; children: string[] }[];
  x0: number;
  y0: number;
  w: number;
  h: number;
  implied: EngineEdge[];
  dropped: EngineEdge[];
}

/** One group's drawing. With a width, rows wider than it wrap into bands; with null, it keeps its natural width. */
function draw(maps: readonly MapNode[], shown: ReadonlySet<string>, width: number | null): Drawn {
  const graph = dependencyGraph(maps, shown);
  const size = (id: string) => (id === ROOT ? { w: 1, h: 1 } : CARD);
  const { layout, plan } = layoutTree({ root: ROOT, nodes: graph.nodes, edges: graph.edges.filter((e) => e.from !== ROOT), size, metrics: METRICS,
    wrapWidth: width === null ? undefined : Math.max(CARD.w, width - 8), ranks: bottomUp(graph) });
  const routed = route(plan, { boxes: layout.boxes, dummyX: (key) => layout.dummies.get(key)!.x });
  const cards = graph.nodes.filter((id) => id !== ROOT).map((id) => ({ id, rect: layout.boxes.get(id)! as Rect }));
  const lines: Drawn["lines"] = [];
  for (const pe of plan.edges.values()) {
    if (pe.from === ROOT) continue;
    const re = routed.edges.get(pe.key);
    if (!re) continue;
    const mutual = graph.mutual.has(pe.key);
    const heads = mutual ? [polygonPath(headDown(re.points[0], METRICS.arrow))] : [];
    const own = routed.heads.get(pe.key);
    if (own) heads.push(polygonPath(own));
    lines.push({ key: pe.key, from: pe.from, to: pe.to, d: roundedPath(re.points, METRICS.radius), heads, mutual });
  }
  const stems: Drawn["stems"] = [];
  for (const [parent, rb] of routed.buses) {
    if (parent === ROOT) continue;
    const children = [...plan.edges.values()].filter((pe) => pe.bus && pe.from === parent).map((pe) => pe.to);
    stems.push({ parent, d: roundedPath(rb.stem, METRICS.radius), head: polygonPath(rb.head), children });
  }
  const xs = cards.flatMap((c) => [c.rect.x, c.rect.x + c.rect.w]);
  const ys = cards.flatMap((c) => [c.rect.y, c.rect.y + c.rect.h]);
  const pad = 4;
  const x0 = Math.min(...xs) - pad;
  const y0 = Math.min(...ys) - pad;
  return { key: [...shown].sort().join("|"), cards, lines, stems, x0, y0, w: Math.max(...xs) - x0 + pad, h: Math.max(...ys) - y0 + pad, implied: graph.implied, dropped: graph.dropped };
}

interface FigureProps {
  maps: readonly MapNode[];
  byPath: Map<string, MapNode>;
  shown: ReadonlySet<string>;
  current: string;
  tracker: string;
  home: string;
  /** Fit the drawing to its box by wrapping wide rows; otherwise draw it at its natural width and scale it down to fit. */
  wrap: boolean;
}

/** The drawings of the shown maps: one per group joined by citations, then the maps with no citation either way. */
function Figure({ maps, byPath, shown, current, tracker, home, wrap }: FigureProps) {
  const [lit, setLit] = useState<string | null>(null);
  const [width, setWidth] = useState(0);
  const box = useRef<HTMLDivElement>(null);
  useLayoutEffect(() => {
    const el = box.current;
    if (!el) return;
    const read = () => setWidth(Math.floor(el.clientWidth));
    read();
    const observer = new ResizeObserver(read);
    observer.observe(el);
    return () => observer.disconnect();
  }, []);
  const drawing = useMemo(() => {
    if (!width) return null;
    const { groups, alone } = citationGroups(maps, shown);
    const title = (p: string) => byPath.get(p)?.title ?? p;
    const stages = groups.map((g) => draw(maps, g, wrap ? width : null));
    // Drawn at full size, as on physlib.io: a drawing wider than its box scrolls instead of shrinking.
    const k = 1;
    return { stages, k, alone: alone.sort((a, b) => title(a).localeCompare(title(b))) };
  }, [maps, shown, width, byPath, wrap]);
  const neighbours = useMemo(() => {
    if (!lit) return null;
    const m = byPath.get(lit);
    return new Set([lit, ...(m?.cites ?? []), ...maps.filter((x) => x.cites.includes(lit)).map((x) => x.path)]);
  }, [lit, byPath, maps]);
  const name = (p: string) => byPath.get(p)?.title ?? p;
  const implied = drawing?.stages.flatMap((s) => s.implied) ?? [];
  const dropped = drawing?.stages.flatMap((s) => s.dropped) ?? [];

  const card = (id: string, rect?: Rect, origin?: { x: number; y: number }) => {
    const m = byPath.get(id)!;
    const here = id === current;
    const share = m.total ? m.done / m.total : 0;
    return (
      <a key={id} href={here ? home : `${tracker}#${id}`} className={`deps__card${here ? " is-current" : ""}${rect ? "" : " is-flow"}${neighbours && !neighbours.has(id) ? " is-dim" : ""}`}
        style={rect && origin ? { left: rect.x - origin.x, top: rect.y - origin.y, width: rect.w, height: rect.h } : undefined}
        aria-current={here ? "page" : undefined}
        aria-label={`${m.title}, ${claims(m)}${here ? ", this page" : ", opens on physlib.io"}`}
        onPointerEnter={() => setLit(id)} onPointerLeave={() => setLit(null)} onFocus={() => setLit(id)} onBlur={() => setLit(null)}>
        <span className="deps__title">{m.title}</span>
        <span className="deps__claims">
          <span className="deps__bar" aria-hidden="true"><span style={{ width: `${Math.round(share * 100)}%` }} /></span>
          <span className="deps__count">{claims(m)}</span>
        </span>
      </a>
    );
  };

  return (
    <>
      <div className="deps__figure" ref={box}>
        {drawing?.stages.map((d) => (
          <div key={d.key} className="deps__frame" style={{ width: d.w * drawing.k, height: d.h * drawing.k, marginLeft: Math.max(0, (width - d.w * drawing.k) / 2) }}>
            <div className="deps__stage" style={{ width: d.w, height: d.h, transform: drawing.k < 1 ? `scale(${drawing.k})` : undefined }}
              data-lit={lit && d.cards.some((c) => c.id === lit) ? "" : undefined}>
              <svg className="deps__lines" width={d.w} height={d.h} viewBox={`${d.x0} ${d.y0} ${d.w} ${d.h}`} aria-hidden="true">
                {d.lines.map((l) => (
                  <g key={l.key} className={`deps__line${l.mutual ? " is-mutual" : ""}${lit !== null && (l.from === lit || l.to === lit) ? " is-lit" : ""}`}>
                    <path d={l.d} />
                    {l.heads.map((hd, i) => <path key={i} className="deps__head" d={hd} />)}
                  </g>
                ))}
                {d.stems.map((s) => (
                  <g key={s.parent} className={`deps__line${lit !== null && (s.parent === lit || s.children.includes(lit)) ? " is-lit" : ""}`}>
                    <path d={s.d} />
                    <path className="deps__head" d={s.head} />
                  </g>
                ))}
              </svg>
              {d.cards.map(({ id, rect }) => card(id, rect, { x: d.x0, y: d.y0 }))}
            </div>
          </div>
        ))}
        {drawing && drawing.alone.length > 0 && (
          <div className="deps__alone">
            <h3>Maps that cite no other map and are not cited</h3>
            <div className="deps__flow">{drawing.alone.map((id) => card(id))}</div>
          </div>
        )}
      </div>
      {(implied.length > 0 || dropped.length > 0) && (
        <details className="deps__hidden">
          <summary>{implied.length + dropped.length} {implied.length + dropped.length === 1 ? "citation is" : "citations are"} not drawn</summary>
          {implied.length > 0 && <p>A citation is left out when a longer chain of drawn citations already joins the same two maps.</p>}
          <ul>
            {[...implied, ...dropped].map((e) => <li key={e.key}>{name(e.from)} cites {name(e.to)}</li>)}
          </ul>
        </details>
      )}
    </>
  );
}

const KEY = "Each map sits above the maps it cites, and the arrow points to the map that does the citing. A dashed line with an arrowhead at both ends joins two maps that cite each other. Each card opens that map on physlib.io.";

export function DependencyMap({ maps, current, tracker, home, id = "dependency-map", compact = false }: {
  maps: readonly MapNode[]; current: string; tracker: string; home: string; id?: string; compact?: boolean;
}) {
  const [all, setAll] = useState(false);
  const dialog = useRef<HTMLDialogElement>(null);
  const byPath = useMemo(() => new Map(maps.map((m) => [m.path, m])), [maps]);
  const { near, below, above } = useMemo(() => {
    const citedBy = (p: string) => maps.filter((m) => m.cites.includes(p)).map((m) => m.path);
    const below = reach(current, (p) => byPath.get(p)?.cites ?? []);
    const above = reach(current, citedBy);
    return { near: new Set([current, ...below, ...above]), below: below.size, above: above.size };
  }, [maps, byPath, current]);
  const everything = useMemo(() => new Set(maps.map((m) => m.path)), [maps]);
  const title = byPath.get(current)?.title ?? current;
  const shared = { maps, byPath, current, tracker, home };
  const open = () => {
    setAll(true);
    dialog.current?.showModal();
  };
  const fullMap = <button type="button" className="deps__open" onClick={open}>See all {maps.length} API maps in Physlib</button>;

  return (
    <section className="api-map__deps" id={id} aria-labelledby={`${id}-title`}>
      <h2 id={`${id}-title`}>Dependency map</h2>
      <p className="deps__lede">
        {compact ? "Arrows point from a cited API map to the map that cites it." : (
          <>{title} cites {below} {below === 1 ? "API map" : "API maps"}, directly or through other maps, and {above === 1 ? "1 map cites" : `${above} maps cite`} it in the same way. {KEY}</>
        )}
      </p>
      {!compact && fullMap}
      <Figure {...shared} shown={near} wrap />
      {compact && fullMap}
      <dialog ref={dialog} className="deps__dialog" aria-labelledby={`${id}-all-title`} onClose={() => setAll(false)}
        onClick={(event) => { if (event.target === dialog.current) dialog.current.close(); }}>
        <div className="deps__dialog-bar">
          <div>
            <h2 id={`${id}-all-title`}>All {maps.length} API maps in Physlib</h2>
            <p>Grouped by the citations that join them. {KEY}</p>
          </div>
          <button type="button" className="deps__close" onClick={() => dialog.current?.close()} autoFocus>Close</button>
        </div>
        <div className="deps__dialog-body">{all && <Figure {...shared} shown={everything} wrap={false} />}</div>
      </dialog>
    </section>
  );
}
