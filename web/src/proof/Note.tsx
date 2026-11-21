import type { Declaration } from "../app/edition";

/** A note of ours on a declaration. A reading note on the Lean (`on: "lean"`) rests on the
 *  declaration's own source; any other note rests on the passages it names. Its typeset
 *  form, when it has formulas, was set by KaTeX at build time from the note's text. */
export function DeclNote({ note }: { note: NonNullable<Declaration["note"]> }) {
  return (
    <p className="decl__note">
      <span className="decl__note-by">{note.on === "lean" ? "Note on this Lean, added for this page" : "Note added for this page"}</span>
      {note.summary && <strong className="decl__note-summary">{note.summary}. </strong>}
      {note.html ? <span dangerouslySetInnerHTML={{ __html: note.html }} /> : note.text}
    </p>
  );
}
