// The divider between the paper and the proof. Drag it, or use the arrow keys, to give
// either side more of the window; a double click puts it back. The choice is remembered.
// Adapted from the Quartic Reader's ReaderSplit (itself after ProofPage's handle here):
// pointer capture, one CSS property written while dragging, a persisted share.

import { useLayoutEffect, useRef, useState } from "react";

const KEY = "proof-reader-paper-share-1";
/** The narrowest either side may become, in pixels. */
const MIN_PAPER = 420;
const MIN_PROOF = 420;
const GUTTER = 26;

function stored(): number | null {
  try {
    const n = Number(localStorage.getItem(KEY));
    return n > 0.15 && n < 0.85 ? n : null;
  } catch {
    return null;
  }
}

export function PaperSplit() {
  // The paper's share of the window; none until the reader chooses one.
  const [share, setShare] = useState<number | null>(stored);
  const [now, setNow] = useState(44);
  const handle = useRef<HTMLDivElement>(null);
  // The open book this divider stands in. Read from the handle: a parent's ref is not yet
  // set when this component's first layout effect runs.
  const root = { get current() { return handle.current?.closest<HTMLElement>(".spread") ?? null; } };

  const bounds = () => {
    const el = root.current;
    const width = el?.clientWidth || window.innerWidth;
    const rail = el ? parseFloat(getComputedStyle(el).getPropertyValue("--rail-width")) || 0 : 0;
    return { width, low: MIN_PAPER / width, high: Math.max(MIN_PAPER / width, (width - rail - GUTTER - MIN_PROOF) / width) };
  };
  const write = (value: number | null) => {
    const el = root.current;
    if (!el) return;
    if (value === null) el.style.removeProperty("--paper-w");
    else el.style.setProperty("--paper-w", `${(value * 100).toFixed(2)}%`);
  };
  const apply = (value: number | null, save = true) => {
    const { low, high } = bounds();
    const next = value === null ? null : Math.min(high, Math.max(low, value));
    write(next);
    setShare(next);
    if (!save) return;
    try {
      if (next === null) localStorage.removeItem(KEY);
      else localStorage.setItem(KEY, String(next));
    } catch {
      /* storage unavailable: the choice lasts until the page closes */
    }
  };
  /** Where the divider stands now, as a share of the window, whoever put it there. */
  const measured = () => {
    const el = root.current;
    const paper = el?.querySelector<HTMLElement>(".left");
    return el && paper ? paper.getBoundingClientRect().width / el.clientWidth : 0.44;
  };

  useLayoutEffect(() => {
    const el = root.current;
    if (!el) return;
    apply(share, false);
    const measure = () => setNow(Math.round(measured() * 100));
    measure();
    // A narrower window may no longer hold the stored share: clamp it again.
    const observer = new ResizeObserver(() => {
      const kept = stored();
      if (kept !== null) {
        const { low, high } = bounds();
        write(Math.min(high, Math.max(low, kept)));
      }
      measure();
    });
    observer.observe(el);
    return () => {
      observer.disconnect();
      el.style.removeProperty("--paper-w");
      el.classList.remove("is-resizing");
    };
    // The stored share is applied once; dragging writes the same property.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div
      ref={handle}
      className="papersplit"
      role="separator"
      aria-orientation="vertical"
      aria-label="Resize the paper and the proof"
      aria-valuemin={Math.round(bounds().low * 100)}
      aria-valuemax={Math.round(bounds().high * 100)}
      aria-valuenow={now}
      aria-valuetext={`The paper has ${now} percent of the window`}
      tabIndex={0}
      title="Drag to resize. Arrow keys adjust; double-click resets."
      onDoubleClick={() => apply(null)}
      onKeyDown={(event) => {
        if (!["ArrowLeft", "ArrowRight", "Home", "Enter"].includes(event.key)) return;
        event.preventDefault();
        event.stopPropagation();
        if (event.key === "Home" || event.key === "Enter") apply(null);
        else apply((share ?? measured()) + (event.key === "ArrowRight" ? 0.025 : -0.025));
      }}
      onPointerDown={(event) => {
        const el = root.current;
        if (event.button !== 0 || !el) return;
        event.preventDefault();
        const grip = event.currentTarget;
        grip.setPointerCapture(event.pointerId);
        el.classList.add("is-resizing");
        const rail = parseFloat(getComputedStyle(el).getPropertyValue("--rail-width")) || 0;
        // Keep the point that was pressed under the pointer.
        const grab = event.clientX - grip.getBoundingClientRect().left;
        const move = (e: PointerEvent) => {
          const box = el.getBoundingClientRect();
          apply((e.clientX - grab - box.left - rail) / box.width, false);
        };
        const end = () => {
          grip.removeEventListener("pointermove", move);
          grip.removeEventListener("pointerup", end);
          grip.removeEventListener("pointercancel", end);
          el.classList.remove("is-resizing");
          // Save where the drag ended, or nothing if the press never moved.
          const at = el.style.getPropertyValue("--paper-w");
          if (at) apply(parseFloat(at) / 100);
        };
        grip.addEventListener("pointermove", move);
        grip.addEventListener("pointerup", end);
        grip.addEventListener("pointercancel", end);
      }}
    >
      <span aria-hidden="true" />
    </div>
  );
}
