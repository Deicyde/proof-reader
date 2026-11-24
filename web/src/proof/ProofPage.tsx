// The right-hand page has two views behind one toggle, Graph and Lean, as docs/graph-pane.md
// describes. Each fills the page. The Graph view is the drawing with a dock under it that
// shows one card in detail; a handle between them sets the dock's height, which is
// remembered. The Lean view is the Lean of the same subject, the whole height of the page.
// A caption says what the page is following. Adapted from Lean Exposition's docked record sheet.

import { ModeToggle, type PaneMode } from "./ModeToggle";
import { memo, useLayoutEffect, useRef, useState, type ReactNode } from "react";

// The key changes when the layout does, so a layout saved under the old one does not apply.
const KEY = "proof-reader-pane-5";
/** The drawing takes up to this much of the pane before the reader moves the divider. */
const OPENING = 0.7;
const GRAPH_MIN = 0.15;
const MIN_LEAN_HEIGHT = 144;
const GRAPH_MAX = 0.85;
const pull = (value: number) => Math.max(GRAPH_MIN, Math.min(GRAPH_MAX, value));

export interface Layout {
  /** Whether the right page is open where it can be closed. */
  graph: boolean;
  /** The Lean view; otherwise the Graph view. */
  lean: boolean;
  /** In the Graph view, the drawing's share of the page above the dock. */
  dock: number;
  dockManual?: boolean;
}

export function readLayout(): Layout {
  const fallback = { graph: true, lean: false, dock: OPENING };
  try {
    const stored = JSON.parse(localStorage.getItem(KEY) ?? "null") as Partial<Layout> | null;
    if (!stored) return fallback;
    // Closing the right page lasts only for this visit.
    const dock = pull(stored.dock ?? OPENING);
    return { graph: true, lean: stored.lean ?? false, dock, dockManual: stored.dockManual ?? dock !== OPENING };
  } catch {
    return fallback;
  }
}

export function saveLayout(layout: Layout) {
  try {
    const { lean, dock, dockManual } = layout;
    localStorage.setItem(KEY, JSON.stringify({ lean, dock, dockManual }));
  } catch {
    /* storage unavailable: the choice lasts until the page closes */
  }
}

interface Props {
  caption: ReactNode;
  /** One line under the Lean view: what is under the pointer. */
  reading: ReactNode;
  graph(availableHeight: number, onFitHeight: (height: number) => void): ReactNode;
  lean: ReactNode;
  leanOpen: boolean;
  /** No graph: the page is the Lean alone, with no toggle and no handle. */
  plain?: boolean;
  onMode(mode: PaneMode): void;
  layout: Layout;
  onLayout(next: Layout): void;
  /** The page can be closed: on demand under 1280px, and in the Graph view above it. */
  onClose?(): void;
}

export const ProofPage = memo(function ProofPage({ caption, reading, graph, lean, leanOpen, plain, onMode, layout, onLayout, onClose }: Props) {
  const panes = useRef<HTMLDivElement>(null);
  const [dragging, setDragging] = useState(false);
  const [paneHeight, setPaneHeight] = useState(0);
  const [leanHeight, setLeanHeight] = useState<number>();
  const [fitHeight, setFitHeight] = useState(0);
  const dock = !plain && !leanOpen;
  const availableHeight = layout.dock * paneHeight;
  const graphLimit = Math.max(availableHeight, paneHeight - MIN_LEAN_HEIGHT);
  const share = !layout.dockManual && fitHeight > 0 && paneHeight > 0 && leanHeight !== undefined
    ? Math.max(Math.min(fitHeight, graphLimit), Math.min(availableHeight, paneHeight - leanHeight)) / paneHeight
    : layout.dock;
  useLayoutEffect(() => {
    const element = panes.current;
    if (!element || !dock) return;
    const lean = element.querySelector(".proof__lean");
    if (!lean) return;
    const measure = () => {
      setPaneHeight(element.clientHeight);
      const body = lean.querySelector<HTMLElement>(".leaf__body");
      const divider = element.querySelector<HTMLElement>(".proof__handle");
      if (!body) return;
      const top = body.getBoundingClientRect().top;
      const bottom = Math.max(top, ...Array.from(body.children, (child) => child.getBoundingClientRect().bottom));
      const chrome = lean.clientHeight - body.clientHeight + (divider?.offsetHeight ?? 0);
      setLeanHeight(Math.ceil(bottom - top + body.scrollTop + chrome));
    };
    const observer = new ResizeObserver(measure);
    const connect = () => {
      observer.disconnect();
      observer.observe(element);
      const body = lean.querySelector(".leaf__body");
      if (body) for (const child of body.children) observer.observe(child);
      measure();
    };
    connect();
    const content = new MutationObserver(connect);
    content.observe(lean, { childList: true, subtree: true });
    return () => {
      content.disconnect();
      observer.disconnect();
    };
  }, [dock]);
  useLayoutEffect(() => panes.current?.style.setProperty("--share", String(share)), [share]);

  // The drag writes one custom property; the panes hear the new room when it ends.
  const onPointerDown = (event: React.PointerEvent<HTMLDivElement>) => {
    if (event.button !== 0 || !panes.current) return;
    event.preventDefault();
    const handle = event.currentTarget;
    handle.setPointerCapture(event.pointerId);
    const box = panes.current.getBoundingClientRect();
    let value = share;
    let moved = false;
    setDragging(true);
    const move = (e: PointerEvent) => {
      moved = true;
      value = pull((e.clientY - box.top) / box.height);
      panes.current?.style.setProperty("--share", String(value));
    };
    const end = () => {
      handle.removeEventListener("pointermove", move);
      handle.removeEventListener("pointerup", end);
      handle.removeEventListener("pointercancel", end);
      setDragging(false);
      if (moved) onLayout({ ...layout, dock: value, dockManual: true });
    };
    handle.addEventListener("pointermove", move);
    handle.addEventListener("pointerup", end);
    handle.addEventListener("pointercancel", end);
  };

  const onHandleKey = (event: React.KeyboardEvent) => {
    if (event.key !== "ArrowUp" && event.key !== "ArrowDown") return;
    event.preventDefault();
    event.stopPropagation();
    onLayout({ ...layout, dock: pull(share + (event.key === "ArrowDown" ? 0.05 : -0.05)), dockManual: true });
  };

  return (
    <div className="proof" data-lean={leanOpen || undefined} data-dock={dock || undefined} aria-label="The proof" role="region">
      <div className="proof__caption">
        <div className="proof__says">{caption}</div>
        {!plain && <ModeToggle mode={leanOpen ? "lean" : "graph"} onMode={onMode} />}
        {onClose && <button type="button" className="proof__close" onClick={onClose}>Close</button>}
      </div>
      <div className={`proof__panes${dragging ? " is-dragging" : ""}`} ref={panes}>
        {!plain && <div className="proof__graph" hidden={!dock}>{graph(availableHeight, setFitHeight)}</div>}
        {dock && <div
          className="proof__handle"
          role="separator"
          aria-orientation="horizontal"
          aria-label="Drag to share the page between the graph and the Lean under it"
          aria-valuemin={Math.round(Math.min(GRAPH_MIN, share) * 100)}
          aria-valuemax={Math.round(GRAPH_MAX * 100)}
          aria-valuenow={Math.round(share * 100)}
          tabIndex={0}
          onPointerDown={onPointerDown}
          onKeyDown={onHandleKey}
        >
          <span aria-hidden="true" />
        </div>}
        <div className="proof__lean">{lean}</div>
      </div>
      {reading && leanOpen && <div className="proof__reading">{reading}</div>}
    </div>
  );
});
