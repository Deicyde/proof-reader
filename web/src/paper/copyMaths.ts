// Copying typeset maths gives the formula as plain Unicode text, the way
// Physlib's API maps write it: "U(x₀, x₁) = x₀² + x₀x₁ + x₁²", not KaTeX's
// MathML and box layout one symbol to a line. A formula is selected whole
// (reading.css sets `user-select: all` on it), so what is highlighted is what
// is copied. TeX the plain rules do not cover is copied as its TeX source.

import { plainMaths } from "./plainMaths";

function plainOf(formula: Element): string {
  const original = formula.closest<HTMLElement>("[data-copy-math]")?.dataset.copyMath;
  if (original !== undefined) return original;
  const tex = formula.querySelector('annotation[encoding="application/x-tex"]')?.textContent?.trim();
  if (!tex) return formula.querySelector(".katex-mathml")?.textContent ?? "";
  try {
    return plainMaths(tex);
  } catch {
    return `$${tex}$`;
  }
}

const formulaAt = (node: Node): Element | null | undefined =>
  (node instanceof Element ? node : node.parentElement)?.closest(".katex-display, .katex");

export function installMathsCopy(root: Document = document): void {
  root.addEventListener("copy", (event) => {
    const selection = root.getSelection();
    if (!selection || selection.isCollapsed || !event.clipboardData) return;
    const range = selection.getRangeAt(0).cloneRange();
    const first = formulaAt(range.startContainer);
    const last = formulaAt(range.endContainer);
    if (first) range.setStartBefore(first.closest("[data-copy-math]") ?? first);
    if (last) range.setEndAfter(last.closest("[data-copy-math]") ?? last);
    const fragment = range.cloneContents();
    const formulas = fragment.querySelectorAll(".katex");
    if (!formulas.length) return;
    formulas.forEach((formula) => formula.replaceWith(root.createTextNode(plainOf(formula))));
    // Read the text the way the page lays it out, so paragraphs and display
    // formulas keep their own lines.
    const holder = root.createElement("div");
    holder.style.cssText = "position:fixed;left:-99999px;top:0;white-space:normal";
    holder.append(fragment);
    root.body.append(holder);
    const text = holder.innerText.replace(/\n{3,}/g, "\n\n").trim();
    const html = holder.innerHTML;
    holder.remove();
    event.clipboardData.setData("text/plain", text);
    event.clipboardData.setData("text/html", html);
    event.preventDefault();
  });
}
