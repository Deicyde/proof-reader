import type { ReactNode } from "react";
import type { Declaration } from "../app/edition";

export function NoteCredit({ children }: { children: ReactNode }) {
  return <details className="note-credit">
    <summary>Note credit</summary>
    <p>{children}</p>
  </details>;
}

/** A note added for this page, drawn from the Lean or from the passages it cites. */
export function DeclNote({ note }: { note: NonNullable<Declaration["note"]> }) {
  return (
    <div className="decl__note">
      <p>
        {note.summary && <strong className="decl__note-summary">{note.summary}. </strong>}
        {note.html ? <span dangerouslySetInnerHTML={{ __html: note.html }} /> : note.text}
      </p>
      <NoteCredit>{note.on === "lean" ? "Proof Reader used AI to draft this explanation of the Lean." : "Proof Reader used AI to draft this note."}</NoteCredit>
    </div>
  );
}
