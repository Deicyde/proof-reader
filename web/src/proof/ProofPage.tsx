// The right-hand page has two modes behind one toggle. It opens in Lean mode, where the Lean of
// the statement being read follows the reader. In Graph mode the graph has the top half, fitted to what
// is in hand, and the Lean of the same thing is docked under it; the graph never takes the whole
// page, and on a short page it folds to a strip. In Lean mode the Lean has the whole page; anyone who wants both pulls the handle down
// for a band of graph, or a column of it where the page is wide. The split is remembered. A
// caption says what the page is following. Adapted from Lean Exposition's docked record sheet.

import { ModeToggle, type PaneMode } from "./ModeToggle";
import { memo, useEffect, useLayoutEffect, useRef, useState, type ReactNode } from "react";

// The key changes when the opening layout does, so a layout saved under the old one does not hide the new.
const KEY = "proof-reader-pane-4";
/** Narrower than this, the graph sits above the Lean; from here they stand side by side. */
const SIDE_BY_SIDE = 1040;
/** What the graph has before the reader pulls the handle: the statement's place in the proof, above or beside its Lean. */
const OPENING = { share: 0.5, sideShare: 0.5, dock: 0.5 };
/** The graph's share in Graph mode stays between these: neither half ever takes the page. */
const DOCK_MIN = 0.25;
const DOCK_MAX = 0.75;
/** A page shorter than this cannot hold two useful halves: the graph folds to a strip. */
const FOLD_BELOW = 560;
const dockPull = (value: number) => Math.max(DOCK_MIN, Math.min(DOCK_MAX, value));
const MAX = 0.78;
/** A pull shorter than this leaves the Lean the whole page. */
const SHUT = 0.08;
/** What a click on the handle gives the graph. */
const BAND = 0.3;

export interface Layout {
  graph: boolean;
  /** Whether the page is in Lean mode. It starts there: the Lean of the statement being read follows the reader. */
  lean: boolean;
  /** The graph's share of the page in Lean mode, stacked and side by side. None until pulled. */
  share: number;
  sideShare: number;
  /** In Graph mode, the graph's share of the page above the docked Lean. */
  dock: number;
}

const pull = (value: number) => (value < SHUT ? 0 : Math.min(MAX, value));

export function readLayout(): Layout {
  const fallback = { graph: true, lean: true, ...OPENING };
  try {
    const stored = JSON.parse(localStorage.getItem(KEY) ?? "null") as Partial<Layout> | null;
    if (!stored) return fallback;
    const clamp = pull;
    // Closing the right page lasts only for this visit. Older saved layouts may
    // contain graph: false; opening a paper must still start side by side.
    return { graph: true, lean: stored.lean ?? true, share: clamp(stored.share ?? fallback.share), sideShare: clamp(stored.sideShare ?? fallback.sideShare), dock: dockPull(stored.dock ?? fallback.dock) };
  } catch {
    return fallback;
  }
}

export function saveLayout(layout: Layout) {
  try {
    const { lean, share, sideShare, dock } = layout;
    localStorage.setItem(KEY, JSON.stringify({ lean, share, sideShare, dock }));
  } catch {
    /* storage unavailable: the choice lasts until the page closes */
  }
}

interface Props {
  caption: ReactNode;
  /** One line under the graph: the key, or what is under the pointer. */
  reading: ReactNode;
  graph: ReactNode;
  lean: ReactNode;
  leanOpen: boolean;
  /** No graph: the page is the Lean alone, with no toggle and no handle. */
  plain?: boolean;
  onMode(mode: PaneMode): void;
  layout: Layout;
  onLayout(next: Layout): void;
  /** The page can be closed: on demand under 1280px, and in Graph mode above it. */
  onClose?(): void;
}

export const ProofPage = memo(function ProofPage({ caption, reading, graph, lean, leanOpen, plain, onMode, layout, onLayout, onClose }: Props) {
  const root = useRef<HTMLDivElement>(null);
  const panes = useRef<HTMLDivElement>(null);
  const [side, setSide] = useState(false);
  const [short, setShort] = useState(false);
  const [dragging, setDragging] = useState(false);
  // Graph mode docks the Lean under the graph: the graph has the top part of the page and the
  // Lean of what is in hand, or of what the paper is reading, has the rest.
  const dock = !plain && !leanOpen;
  const folded = dock && short;

  useLayoutEffect(() => {
    const el = root.current;
    if (!el) return;
    const measure = () => {
      setSide(el.clientWidth >= SIDE_BY_SIDE);
      setShort(el.clientHeight > 0 && el.clientHeight < FOLD_BELOW);
    };
    measure();
    const observer = new ResizeObserver(measure);
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const stacked = dock || !side;
  const share = plain ? 0 : dock ? layout.dock : side ? layout.sideShare : layout.share;
  const withShare = (value: number): Layout => (dock ? { ...layout, dock: dockPull(value) } : side ? { ...layout, sideShare: value } : { ...layout, share: value });
  useEffect(() => panes.current?.style.setProperty("--share", String(share)), [share]);

  const change = onLayout;

  // The drag writes one custom property; the panes hear the new room when it ends. A press
  // that does not move is a click, which opens or closes the Lean.
  const onPointerDown = (event: React.PointerEvent<HTMLDivElement>) => {
    if (event.button !== 0 || !panes.current) return;
    event.preventDefault();
    const handle = event.currentTarget;
    handle.setPointerCapture(event.pointerId);
    const box = panes.current.getBoundingClientRect();
    const from = { x: event.clientX, y: event.clientY };
    const wasOpen = leanOpen;
    const wasDock = dock;
    let value = share;
    let moved = false;
    setDragging(true);
    const move = (e: PointerEvent) => {
      if (!moved && Math.hypot(e.clientX - from.x, e.clientY - from.y) < 5) return;
      if (!moved && !wasOpen && !wasDock) onMode("lean");
      moved = true;
      const at = !stacked ? (e.clientX - box.left) / box.width : (e.clientY - box.top) / box.height;
      value = wasDock ? dockPull(at) : pull(at);
      panes.current?.style.setProperty("--share", String(value));
    };
    const end = () => {
      handle.removeEventListener("pointermove", move);
      handle.removeEventListener("pointerup", end);
      handle.removeEventListener("pointercancel", end);
      setDragging(false);
      if (moved) change(withShare(value));
      else if (wasDock) return;
      else if (wasOpen) change(withShare(share > 0 ? 0 : BAND));
      else onMode("lean");
    };
    handle.addEventListener("pointermove", move);
    handle.addEventListener("pointerup", end);
    handle.addEventListener("pointercancel", end);
  };

  const onHandleKey = (event: React.KeyboardEvent) => {
    const back = !stacked ? "ArrowLeft" : "ArrowUp";
    const on = !stacked ? "ArrowRight" : "ArrowDown";
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      event.stopPropagation();
      if (dock) return;
      if (leanOpen) change(withShare(share > 0 ? 0 : BAND));
      else onMode("lean");
      return;
    }
    if (event.key !== back && event.key !== on) return;
    event.preventDefault();
    event.stopPropagation();
    change(withShare((dock ? dockPull : pull)(share + (event.key === on ? 0.05 : -0.05))));
  };

  const both = (leanOpen && share > 0) || dock;
  const shut = leanOpen && share === 0;
  return (
    <div className="proof" ref={root} data-side={(side && !dock) || undefined} data-lean={leanOpen || undefined} data-dock={dock || undefined} data-folded={folded || undefined} aria-label="The proof" role="region">
      <div className="proof__caption">
        <div className="proof__says">{caption}</div>
        {!plain && <ModeToggle mode={leanOpen ? "lean" : "graph"} onMode={onMode} />}
        {onClose && <button type="button" className="proof__close" onClick={onClose}>Close</button>}
      </div>
      <div className={`proof__panes${both ? " is-both" : ""}${shut ? " is-shut" : ""}${dragging ? " is-dragging" : ""}`} ref={panes}>
        {!plain && <div className="proof__graph">{graph}</div>}
        {!plain && <div
          className="proof__handle"
          role="separator"
          aria-orientation={!stacked ? "vertical" : "horizontal"}
          aria-label={leanOpen ? "Pull the graph in beside the Lean" : "Drag to share the page between the graph and the Lean"}
          aria-valuemin={dock ? Math.round(DOCK_MIN * 100) : 0}
          aria-valuemax={Math.round((dock ? DOCK_MAX : MAX) * 100)}
          aria-valuenow={Math.round(share * 100)}
          tabIndex={0}
          onPointerDown={onPointerDown}
          onKeyDown={onHandleKey}
        >
          <span aria-hidden="true" />
        </div>}
        <div className="proof__lean" hidden={!leanOpen && !dock}>{lean}</div>
      </div>
      {reading && <div className="proof__reading">{reading}</div>}
    </div>
  );
});
