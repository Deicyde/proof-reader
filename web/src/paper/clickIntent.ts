// A click on a linked passage opens it unless the reader is selecting text. A single click on a
// typeset formula can leave its glyph selected (KaTeX's spans select as a unit), so a selection
// alone does not mean the reader is selecting: only a drag, a double click, or a selection made
// without a pointer does.

let down: { x: number; y: number } | null = null;
if (typeof document !== "undefined")
  document.addEventListener("pointerdown", (event) => {
    down = { x: event.clientX, y: event.clientY };
  }, true);

/** Whether text is selected on purpose at this click, so the click should not open anything. */
export function selecting(event: { clientX: number; clientY: number; detail: number }): boolean {
  const selection = window.getSelection();
  if (!selection || selection.isCollapsed || !selection.toString()) return false;
  if (!down || event.detail === 0 || event.detail > 1) return true;
  return Math.hypot(event.clientX - down.x, event.clientY - down.y) > 4;
}
