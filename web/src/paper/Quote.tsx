import type { Passage } from "../app/edition";

/**
 * A passage's words as the reading copy sets them. `quote_html` is written by
 * tools/paper.py from the same Markdown and KaTeX as the reading copy, and is
 * trusted the way that copy is; a PDF-based paper has only the plain `quote`.
 */
export function Quote({ passage }: { passage: Pick<Passage, "quote" | "quote_html"> }) {
  if (passage.quote_html) return <span className="quote-set" dangerouslySetInnerHTML={{ __html: passage.quote_html }} />;
  return <>{passage.quote}</>;
}
