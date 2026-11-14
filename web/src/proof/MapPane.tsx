// The graph of the proof, adapted from Lean Exposition's map beside the paper. It comes
// along with the reading: every branch drawn, the statement under the reading line in
// amber, what lies ahead quieter. A soft green says what Lean holds. The camera moves only
// if a card has left the view. In Lean mode the graph is out of sight, or a band pulled
// down above the Lean with the card in the middle of it, and leaving Lean mode gives the
// camera back exactly. The reader stays in charge: moving the map pauses following.

import { memo, useCallback, useEffect, useImperativeHandle, useLayoutEffect, useMemo, useRef, useState, type Ref } from "react";
import type { Edition } from "../app/edition";
import { ArgumentTree, type Insets, type MapViewHandle } from "../map/ArgumentTree";
import type { MapScene } from "../map/canvas/scene";
import { isType } from "../model/fromEdition";
import type { ArgEdge, ArgGraph } from "../model/graph";

const INSETS: Insets = { top: 10, right: 12, bottom: 10, left: 12 };
/** Narrow tiles, so that at the 11px floor the proof fits half a laptop's window. */
const TILE_W = 134;
const TILE_H = 64;
/** Under this height the graph is the band above the Lean. */
const BAND = 340;
/**
 * Proof Reader, after the Quartic Reader and the Plectis maths site: a map with more cards
 * than this opens on one card and what it uses, with the whole map one click away; and a
 * pane narrower than LIST_BELOW shows the cards as a list.
 */
const MAP_LIMIT = 16;
const LIST_BELOW = 440;
/** Neighbourhood tiles are wider, and each is as tall as its title needs, up to four lines. */
const NEAR_W = 176;
const tileHeight = (title: string, width: number) => {
  const perLine = Math.max(8, Math.floor((width - 14) / 6.6));
  const words = title.split(/\s+/);
  let lines = 1;
  let used = 0;
  for (const w of words) {
    if (used && used + 1 + w.length > perLine) {
      lines += 1;
      used = w.length;
    } else used += (used ? 1 : 0) + w.length;
  }
  return 30 + Math.min(4, lines) * 17;
};

/** One card, what it uses, and nothing else: the neighbourhood of `centre`. At the main
 * result it is the claim, its theorems and what their statements use. Only the edges from
 * the centre's own level are drawn, so every line can be followed. */
export function neighbourhood(graph: ArgGraph, centre: string, goal: string): ArgGraph {
  const level = centre === goal ? [goal, ...(graph.out.get(goal) ?? []).map((e) => e.to)] : [centre];
  const ids = new Set<string>(level);
  for (const id of level) for (const e of graph.out.get(id) ?? []) ids.add(e.to);
  const edges: ArgEdge[] = graph.edges.filter((e) => level.includes(e.from) && ids.has(e.to));
  const nodes = new Map([...graph.nodes].filter(([id]) => ids.has(id)));
  const out = new Map<string, ArgEdge[]>([...ids].map((id) => [id, []]));
  const into = new Map<string, ArgEdge[]>([...ids].map((id) => [id, []]));
  for (const e of edges) {
    out.get(e.from)!.push(e);
    into.get(e.to)!.push(e);
  }
  const members = graph.order.filter((id) => ids.has(id));
  return {
    ...graph,
    nodes,
    order: members,
    edges,
    out,
    in: into,
    regions: [{ id: centre, title: graph.nodes.get(centre)?.label ?? "", goal: centre, members }],
    regionOf: new Map(members.map((id) => [id, centre])),
    goals: [centre],
  };
}

export interface MapPaneHandle {
  scene(): MapScene | null;
  paused(): boolean;
  restore(scene: MapScene | null, paused: boolean): void;
}

interface Props {
  ref?: Ref<MapPaneHandle>;
  edition: Edition;
  graph: ArgGraph;
  /** What the right page is showing: outlined. */
  lit: readonly string[];
  /** Previewed by the pointer: tinted, and nothing moves. */
  pointed: ReadonlySet<string> | null;
  /** Declarations whose statements the reader has passed. */
  passed: ReadonlySet<string>;
  /** How many declarations the reader has reached, and how many there are. */
  reached: number;
  selected: string | null;
  /** Hold the camera still for the next change: a card was just clicked. */
  stay: boolean;
  /** The Lean has the lower part of the page, so the graph has a band. */
  leanOpen: boolean;
  onSelect(id: string): void;
  onHover(id: string | null): void;
  onPauseChange(paused: boolean): void;
}

export const MapPane = memo(function MapPane({ ref, edition, graph: fullGraph, lit, pointed, passed, reached, selected, stay, leanOpen, onSelect, onHover, onPauseChange }: Props) {
  const tree = useRef<MapViewHandle>(null);
  const body = useRef<HTMLDivElement>(null);
  const section = useRef<HTMLElement>(null);
  const { claims } = edition;
  const types = useMemo(() => edition.declarations.filter(isType), [edition]);
  // A map draws one claim's proof. A paper with several gets a switch.
  const [goal, setGoal] = useState(claims[0]?.id ?? "");
  // A large map opens on a neighbourhood; the reader can ask for the whole map.
  const big = fullGraph.nodes.size - claims.length > MAP_LIMIT;
  const [whole, setWhole] = useState(!big);
  const [centre, setCentre] = useState(goal);
  useEffect(() => {
    setCentre(selected && selected !== goal && fullGraph.nodes.has(selected) ? selected : goal);
  }, [selected, goal, fullGraph]);
  const near = !whole;
  const graph = useMemo(() => (near ? neighbourhood(fullGraph, centre, goal) : fullGraph), [near, fullGraph, centre, goal]);
  const root = near ? centre : goal;
  const usedBy = useMemo(() => (near && centre !== goal ? (fullGraph.in.get(centre) ?? []).map((e) => e.from).filter((id) => id !== goal) : []), [near, centre, goal, fullGraph]);
  const heightOf = useCallback((id: string) => tileHeight(fullGraph.nodes.get(id)?.label ?? "", near ? NEAR_W : TILE_W), [fullGraph, near]);
  // A narrow pane, a phone: the cards as a list, which is also the keyboard's way through.
  const [narrow, setNarrow] = useState(false);
  useEffect(() => {
    const el = section.current;
    if (!el) return;
    const observer = new ResizeObserver(() => setNarrow(el.clientWidth > 0 && el.clientWidth < LIST_BELOW));
    observer.observe(el);
    return () => observer.disconnect();
  }, []);
  const claim = claims.find((c) => c.id === goal) ?? claims[0];
  const [paused, setPaused] = useState(false);
  const pausedRef = useRef(false);
  const litIds = useMemo(() => (lit.length ? new Set(lit) : null), [lit]);
  const litKey = lit.join("|");
  const shelf = useRef<HTMLDivElement>(null);
  // The shelf is one line: bring a lit type into it.
  useEffect(() => {
    const row = shelf.current;
    const item = row?.querySelector<HTMLElement>(".is-lit");
    if (row && item) row.scrollLeft = Math.max(0, item.offsetLeft - row.offsetLeft - 8);
  }, [litKey]);
  const stayRef = useRef(stay);
  stayRef.current = stay;
  const leanRef = useRef(leanOpen);
  const before = useRef<MapScene | null>(null);
  const missed = useRef(false);

  // Scrolling must stay smooth, so the trail is written straight onto the tiles.
  const writeTrail = useCallback(() => {
    body.current?.querySelectorAll<HTMLElement>(".card[data-record]").forEach((card) => {
      const id = card.dataset.record!;
      const state = litIds?.has(id) ? "here" : passed.has(id) || id === goal ? "" : "ahead";
      if ((card.dataset.trail ?? "") !== state) card.dataset.trail = state;
    });
  }, [goal, litIds, passed]);
  useEffect(writeTrail);

  const inView = useCallback((ids: readonly string[]) => {
    const canvas = body.current?.getBoundingClientRect();
    if (!canvas?.width) return true;
    return ids.every((id) => {
      const cards = body.current!.querySelectorAll<HTMLElement>(`.card[data-record="${CSS.escape(id)}"]`);
      if (!cards.length) return true;
      return [...cards].some((card) => {
        const r = card.getBoundingClientRect();
        return r.top >= canvas.top && r.bottom <= canvas.bottom && r.left >= canvas.left && r.right <= canvas.right;
      });
    });
  }, []);

  useEffect(() => {
    if (pausedRef.current || stayRef.current || !lit.length) return;
    // Out of sight in Lean mode: catch up on the way back.
    if (!body.current?.clientHeight) {
      missed.current = true;
      return;
    }
    const drawn = lit.filter((id) => graph.nodes.has(id));
    if (drawn.length && leanRef.current && (body.current?.clientHeight ?? 0) < BAND) tree.current?.panTo(drawn, { centre: true });
    else if (drawn.length && !inView(drawn)) tree.current?.panTo(drawn);
    // Only when what is lit changes: the map re-centres itself when its room changes.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [litKey]);

  const setPause = useCallback((next: boolean) => {
    if (pausedRef.current === next) return;
    pausedRef.current = next;
    setPaused(next);
    onPauseChange(next);
  }, [onPauseChange]);

  const restoring = useRef(false);
  useImperativeHandle(ref, (): MapPaneHandle => ({
    scene: () => tree.current?.getScene() ?? null,
    paused: () => pausedRef.current,
    restore: (scene, wasPaused) => {
      pausedRef.current = wasPaused;
      setPaused(wasPaused);
      if (!scene) return;
      restoring.current = true;
      tree.current?.restoreScene(scene);
      window.setTimeout(() => {
        restoring.current = false;
      }, 80);
    },
  }), []);

  // Every branch is drawn from the start, so following only frames; it never folds.
  const litRef = useRef(lit);
  litRef.current = lit;
  const opened = useRef(false);
  useEffect(() => {
    let again = 0;
    const open = window.setTimeout(() => tree.current?.expandAll(), 0);
    const frame = window.setTimeout(() => {
      // A reload or a return to this entry finds the camera the reader left.
      const saved = !opened.current ? (window.history.state as { scene?: MapScene; mapPaused?: boolean } | null) : null;
      opened.current = true;
      if (saved?.mapPaused) {
        pausedRef.current = true;
        setPaused(true);
      }
      if (saved?.scene) {
        const scene = saved.scene;
        tree.current?.restoreScene(scene);
        // A slow first layout can frame the map after this: put the camera back once more.
        again = window.setTimeout(() => {
          if (!pausedRef.current && !leanRef.current) tree.current?.restoreScene(scene);
        }, 400);
      } else {
        tree.current?.fitAll(false);
        if (!pausedRef.current && litRef.current.length && !inView(litRef.current)) tree.current?.panTo(litRef.current);
      }
    }, 80);
    return () => {
      window.clearTimeout(open);
      window.clearTimeout(frame);
      window.clearTimeout(again);
    };
  }, [root, whole, inView]);

  // The Lean rises: remember the camera, to give it back exactly when the Lean goes.
  useLayoutEffect(() => {
    if (leanRef.current === leanOpen) return;
    leanRef.current = leanOpen;
    if (leanOpen) {
      before.current = tree.current?.getScene() ?? null;
      missed.current = false;
    }
  }, [leanOpen]);

  // Back in Graph mode. A resize has given the camera back; if the Lean followed the text
  // while the graph was out of sight, the graph catches up.
  useEffect(() => {
    if (leanOpen) return;
    const timer = window.setTimeout(() => {
      before.current = null;
      if (missed.current && !pausedRef.current && !restoring.current && litRef.current.length && !inView(litRef.current)) tree.current?.panTo(litRef.current);
      missed.current = false;
    }, 240);
    return () => window.clearTimeout(timer);
  }, [inView, leanOpen]);

  // The room changed: the Lean rose or went, the handle was dragged, the window changed.
  useEffect(() => {
    const el = body.current;
    if (!el) return;
    let timer = 0;
    let size = "";
    const observer = new ResizeObserver(() => {
      const next = `${el.clientWidth}x${el.clientHeight}`;
      // Folded away for a statement with no card: the camera waits.
      if (next === size || !el.clientHeight) return;
      const first = !size;
      size = next;
      if (first) return;
      window.clearTimeout(timer);
      timer = window.setTimeout(() => {
        if (restoring.current) return;
        if (leanRef.current) {
          // A band of graph is only useful with the card in the middle of it.
          if (litRef.current.length && el.clientHeight < BAND) tree.current?.panTo(litRef.current, { centre: true });
          else if (litRef.current.length && !inView(litRef.current)) tree.current?.panTo(litRef.current);
        } else if (before.current) {
          tree.current?.restoreScene(before.current);
          before.current = null;
        } else {
          tree.current?.fitAll(false);
          if (litRef.current.length && !inView(litRef.current)) tree.current?.panTo(litRef.current);
        }
      }, 140);
    });
    observer.observe(el);
    return () => {
      observer.disconnect();
      window.clearTimeout(timer);
    };
  }, [inView]);

  // In the neighbourhood, a click on another card brings it into view with what it uses;
  // a click on the card in view opens its Lean, as a click does on the whole map.
  const select = useCallback((id: string | null) => {
    if (!id) return;
    if (near && id !== centre && fullGraph.nodes.get(id)?.kind !== "goal") setCentre(id);
    else onSelect(id);
  }, [near, centre, fullGraph, onSelect]);
  const onUserMove = useCallback(() => setPause(true), [setPause]);
  const noTrace = useCallback(() => undefined, []);

  const map = useMemo(
    () => (
      <ArgumentTree
        key={`${whole ? "whole" : "near"}:${root}`}
        ref={tree}
        graph={graph}
        goal={root}
        insets={INSETS}
        persist={false}
        mode="overview"
        tileWidth={near ? NEAR_W : TILE_W}
        tileHeight={TILE_H}
        tileHeightOf={big ? heightOf : undefined}
        rootLabel={root === goal ? undefined : "In view"}
        oneCardEach
        fitMax={1.8}
        selected={selected ?? undefined}
        litIds={litIds}
        previewIds={pointed}
        rootExcerpt={root === goal ? <span>{claim?.title}</span> : undefined}
        onSelect={select}
        onTrace={noTrace}
        onHover={onHover}
        onUserMove={onUserMove}
      />
    ),
    [goal, root, whole, near, graph, heightOf, selected, litIds, pointed, claim, select, noTrace, onHover, onUserMove],
  );

  return (
    <section ref={section} className={`graph${whole && big ? " graph--quiet" : ""}${near ? " graph--near" : ""}`} aria-label="Graph of the Lean proof">
      {paused && (
        <p className="graph__paused" role="status">
          Paused while you move the graph.
          <button type="button" onClick={() => setPause(false)}>Follow the paper again</button>
        </p>
      )}
      {claims.length > 1 && (
        <div className="claims" role="group" aria-label="Which claim's proof to show">
          {claims.map((c) => (
            <button key={c.id} type="button" aria-pressed={c.id === claim?.id} onClick={() => setGoal(c.id)}>{c.title}</button>
          ))}
        </div>
      )}
      {types.length > 0 && (
        <div className="vocab" aria-label="Types the proof is written in">
          <span className="vocab__name">Types</span>
          <div className="vocab__list" ref={shelf}>
            {types.map((d) => (
              <button key={d.id} type="button" data-vocab={d.id} className={lit.includes(d.id) ? "is-lit" : ""} aria-label={`${d.plain} (${d.id})`} onClick={() => onSelect(d.id)} onMouseEnter={() => onHover(d.id)} onMouseLeave={() => onHover(null)} onFocus={() => onHover(d.id)} onBlur={() => onHover(null)}>
                {d.plain}
              </button>
            ))}
          </div>
          <span className="vocab__reached">{reached} of {edition.declarations.length} declarations reached</span>
        </div>
      )}
      {(big || narrow) && (
        <div className="graph__view" role="group" aria-label="How much of the map to show">
          {!narrow && (
            <button type="button" aria-pressed={whole} onClick={() => setWhole((w) => !w)}>
              {whole ? "Show one card and what it uses" : "Whole map"}
            </button>
          )}
          {near && !narrow && centre !== goal && <button type="button" onClick={() => setCentre(goal)}>Back to the main result</button>}
          {near && !narrow && centre !== goal && <button type="button" onClick={() => onSelect(centre)}>Open its Lean</button>}
          {near && !narrow && usedBy.length > 0 && (
            <span className="graph__usedby">Used by{" "}
              {usedBy.map((id) => <button key={id} type="button" onClick={() => setCentre(id)}>{fullGraph.nodes.get(id)?.label ?? id}</button>)}
            </span>
          )}
          {whole && big && !narrow && <span className="graph__hint">Point at a card to see its lines.</span>}
          {near && !narrow && (
            <span className="graph__hint">
              {centre === goal
                ? "Under the theorem: everything its statement uses. Click a card to see what it uses."
                : `Under it: everything ${fullGraph.nodes.get(centre)?.label ?? centre} uses. Click a card to go on.`}
            </span>
          )}
        </div>
      )}
      {narrow ? <MapList graph={fullGraph} goal={goal} lit={lit} onSelect={onSelect} onHover={onHover} /> : <div className="graph__canvas" ref={body}>{map}</div>}
    </section>
  );
});

/** The map as a list: every card in reading order of the proof, with what it uses and what uses it. */
function MapList({ graph, goal, lit, onSelect, onHover }: { graph: ArgGraph; goal: string; lit: readonly string[]; onSelect(id: string): void; onHover(id: string | null): void }) {
  const label = (id: string) => graph.nodes.get(id)?.label ?? id;
  const ids = graph.order.filter((id) => id !== goal);
  const card = (id: string) => (
    <button type="button" onClick={() => onSelect(id)} onFocus={() => onHover(id)} onBlur={() => onHover(null)}>{label(id)}</button>
  );
  return (
    <ol className="maplist" aria-label="The declarations of the proof, as a list">
      {ids.map((id) => {
        const uses = (graph.out.get(id) ?? []).map((e) => e.to);
        const users = (graph.in.get(id) ?? []).map((e) => e.from).filter((u) => u !== goal);
        return (
          <li key={id} className={lit.includes(id) ? "is-lit" : undefined}>
            <p className="maplist__title">{card(id)} <code>{graph.nodes.get(id)?.rawName}</code></p>
            {uses.length > 0 && <p className="maplist__rel">Uses {uses.map((u, i) => <span key={u}>{i > 0 && ", "}{card(u)}</span>)}</p>}
            {users.length > 0 && <p className="maplist__rel">Used by {users.map((u, i) => <span key={u}>{i > 0 && ", "}{card(u)}</span>)}</p>}
          </li>
        );
      })}
    </ol>
  );
}
