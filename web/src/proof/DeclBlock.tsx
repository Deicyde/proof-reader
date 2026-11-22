// One Lean declaration: what it is, how the sentence relates to it, its signature,
// the rest behind Proof ▶ where that helps, what it uses and what uses it, what Lean
// reports about its axioms, what Comparator checked, where the paper states it and the
// authors' source.

import { useEffect, useState } from "react";
import { declEvidence, declOrigin, noun, passageLocation, type Declaration, type Edition, type Passage } from "../app/edition";

/** Past this many characters, a passage in a declaration's list is named by its opening words. */
const LIST_QUOTE = 160;
const opening = (quote: string) => quote.split(/\s+/).slice(0, 16).join(" ");
import { DeclLink, LeanCode, useFileLines, type LeanActions } from "../lean/code";
import { isType, sectionLabel, shapeOf } from "../model/fromEdition";
import { routeHref } from "../app/router";
import { FidelityBlock } from "./Fidelity";
import { ComparatorFold } from "./Comparator";
import { Quote } from "../paper/Quote";
import { DeclNote } from "./Note";

export const KIND_WORDS: Record<string, string> = {
  theorem: "Theorem",
  lemma: "Lemma",
  def: "Definition",
  abbrev: "Definition",
  instance: "Instance",
  axiom: "Axiom",
  inductive: "Type",
  structure: "Type",
  class: "Type class",
  opaque: "Definition",
};

/** How the paper's words stand to the Lean, saying no more than the two say. */
function relation(p: Passage): string {
  const here = p.code ? "line" : "sentence";
  const words: Record<Passage["role"], string> = {
    states: "States this result.",
    defines: "Defines this term.",
    proves: "Proves a step of this result.",
    explains: `The authors explain it in this ${here}.`,
    uses: `The authors use it in this ${here}.`,
    mentions: `The authors only mention it in this ${here}.`,
    mirrors: "The Lean version of this line of the paper’s Haskell.",
  };
  return words[p.role];
}

export const list = (names: string[]) => (names.length < 2 ? names.join("") : `${names.slice(0, -1).join(", ")} and ${names[names.length - 1]}`);

/** The folded part's name: a proof, or a definition's body. */
export const foldWord = (d: Declaration) => (d.keyword === "theorem" || d.keyword === "lemma" ? "Proof" : "Body");

function Names({ edition, names, act }: { edition: Edition; names: string[]; act: LeanActions }) {
  return (
    <>
      {names.map((name) => (
        <DeclLink key={name} paper={edition.slug} name={name} act={act} className="declname" />
      ))}
    </>
  );
}

/** Lean's axiom report is for the whole declaration. When the page shows a few selected
 *  lines of it, the sentence says so, so the report is not read as a fact about those lines. */
function Axioms({ edition, d, act, part }: { edition: Edition; d: Declaration; act: LeanActions; part: boolean }) {
  if (d.keyword === "axiom") return <p className="decl__axiom">An assumption declared without a proof.</p>;
  if (d.keyword !== "theorem" && d.keyword !== "lemma") return null;
  const evidence = declEvidence(edition, d);
  if (evidence === "statement-compiled") return <p className="decl__facts">No axiom report: the retained Lean extraction compiled the statement only. It did not build the proof.</p>;
  if (evidence === "source-read") return <p className="decl__facts">Read from source. This edition does not have a Lean axiom report for the proof.</p>;
  const sorry = edition.analytics.sorry.includes(d.id);
  const whole = `the whole ${d.keyword}${d.lines > 1 ? `, lines ${d.line} to ${d.end_line},` : ""}`;
  return (
    <p className="decl__facts">
      {d.axioms.length > 0 ? (
        <>
          Lean reports that {whole} depends on the authors’ axiom <Names edition={edition} names={d.axioms} act={act} />
          {d.standard_axioms.length > 0 && <>, and on Lean’s standard {list(d.standard_axioms)}</>}.
        </>
      ) : d.standard_axioms.length > 0 ? (
        <>Lean reports that {whole} depends on its standard {list(d.standard_axioms)}.</>
      ) : !sorry && (
        <>Lean reports that {whole} depends on no axioms.</>
      )}
      {part && !sorry && <> Lean gives no separate report for the highlighted lines.</>}
      {sorry && <strong> It contains sorry.</strong>}
    </p>
  );
}

/** Adapted from Lean Exposition's CopyName. */
function CopyName({ name }: { name: string }) {
  const [copied, setCopied] = useState(false);
  useEffect(() => {
    if (!copied) return;
    const timer = window.setTimeout(() => setCopied(false), 1600);
    return () => window.clearTimeout(timer);
  }, [copied]);
  return (
    <button type="button" className="decl__copy" onClick={() => void navigator.clipboard?.writeText(name).then(() => setCopied(true))}>
      <span aria-live="polite">{copied ? "Copied" : "Copy name"}</span>
    </button>
  );
}

interface Props {
  edition: Edition;
  d: Declaration;
  /** The sentence this block answers, when there is one. */
  passage?: Passage;
  exact?: [number, number] | null;
  open: boolean;
  onToggle(id: string): void;
  onPassage(id: string): void;
  act: LeanActions;
  names: ReadonlySet<string>;
  /** The code and the authors' comment only: no uses, no list of places. */
  compact?: boolean;
}

export function DeclBlock({ edition, d, passage, exact, open, onToggle, onPassage, act, names, compact }: Props) {
  const lines = useFileLines(edition.lean.files[d.file]);
  const rest = d.end_line - d.statement_end;
  const word = foldWord(d);
  const evidence = declEvidence(edition, d);
  const statementUses = d.uses_statement;
  const bodyUses = d.uses_proof;
  const passages = d.passages.map((id) => edition.passages.find((p) => p.id === id)).filter((p): p is Passage => !!p);
  const path = d.file.replace(/^lean\//, "");
  const sourceLines = edition.lean.source_lines?.replace("{path}", path).replace("{line}", String(d.line)).replace("{end}", String(d.end_line));
  const source = sourceLines ?? edition.lean.source;
  const range = d.line === d.end_line ? `line ${d.line}` : `lines ${d.line}–${d.end_line}`;
  return (
    <article className="decl" data-shape={shapeOf(d)} data-decl={d.id} data-source-read={evidence !== "lean" || undefined}>
      <header className="decl__head">
        <h3 className="decl__name"><a href={routeHref({ paper: edition.slug, record: d.id })}>{d.plain}</a></h3>
        <code className="decl__raw">{d.id}</code>
        <CopyName name={d.id} />
        <span className="decl__kind">
          {KIND_WORDS[d.keyword] ?? d.keyword} · {sourceLines ? (
            <a href={sourceLines} target="_blank" rel="noopener noreferrer" title={`Open ${d.id} in its Lean file`}>{range}</a>
          ) : range} · {declOrigin(edition, d)}
        </span>
      </header>
      {passage && !compact && <p className="decl__relation">{relation(passage)}</p>}
      {d.note && <DeclNote note={d.note} />}
      <FidelityBlock edition={edition} d={d} act={act} onPassage={onPassage} />
      <Axioms edition={edition} d={d} act={act} part={!!exact && (exact[0] > d.line || exact[1] < d.end_line)} />
      <ComparatorFold edition={edition} d={d} names={names} act={act} />
      <div className="decl__code" tabIndex={0} aria-label={`Statement of ${d.id}`}>
        <LeanCode paper={edition.slug} lines={lines} from={d.line} to={d.statement_end} names={names} self={d.id} exact={exact} act={act} />
      </div>
      {rest > 0 && (
        <>
          <button type="button" className="decl__fold" aria-expanded={open} onClick={() => onToggle(d.id)}>
            <span aria-hidden="true">{open ? "▼" : "▶"}</span> {word}, {rest} line{rest > 1 ? "s" : ""}
          </button>
          {open && (
            <div className="decl__code" tabIndex={0} aria-label={`${word} of ${d.id}`}>
              <LeanCode paper={edition.slug} lines={lines} from={d.statement_end + 1} to={d.end_line} names={names} self={d.id} exact={exact} act={act} />
            </div>
          )}
        </>
      )}
      {d.comment && (
        <div className="decl__comment">
          <p className="decl__label">The authors’ comment above it</p>
          <LeanCode paper={edition.slug} lines={lines} from={d.comment[0]} to={d.comment[1]} names={names} act={act} />
        </div>
      )}
      {!compact && <div className="decl__links">
        <div>
          <p className="decl__label">Names in this statement</p>
          {statementUses.length > 0 && <Names edition={edition} names={statementUses} act={act} />}
          {bodyUses.length > 0 && <><p className="decl__label">Only in its {word.toLowerCase()}</p><Names edition={edition} names={bodyUses} act={act} /></>}
          {!statementUses.length && !bodyUses.length && evidence === "lean" && <p>Nothing else on this page.</p>}
          {evidence !== "lean" && <p>Dependencies in the {word.toLowerCase()} have not been extracted for this declaration.</p>}
        </div>
        <div>
          <p className="decl__label">Used by</p>
          {d.used_by_statement.length > 0 && <p>In the statement of: <Names edition={edition} names={d.used_by_statement} act={act} /></p>}
          {d.used_by_proof.length > 0 && <p>Only in the {isType(d) ? "definition or proof" : "proof or body"} of: <Names edition={edition} names={d.used_by_proof} act={act} /></p>}
          {!d.used_by.length && <p>No uses recorded on this page.</p>}
        </div>
      </div>}
      {!compact && passages.length > 0 && (
        <div className="decl__where">
          <p className="decl__label">In the {noun(edition)}</p>
          <ul>
            {passages.map((p) => (
              <li key={p.id}>
                <a
                  href={routeHref({ paper: edition.slug, record: `@${p.id}` })}
                  onClick={(event) => {
                    if (event.metaKey || event.ctrlKey || event.shiftKey) return;
                    event.preventDefault();
                    onPassage(p.id);
                  }}
                >
                  <span className="decl__at">{sectionLabel(p.section)}, {passageLocation(p)}</span>{" "}
                  {/* A list of places, not a reading: a long paragraph is named by its opening words. */}
                  {p.quote.length > LIST_QUOTE ? <span className="decl__opening">{opening(p.quote)}…</span> : <Quote passage={p} />}
                </a>
              </li>
            ))}
          </ul>
        </div>
      )}
      <p className="decl__source">
        <a href={source} target="_blank" rel="noopener noreferrer">{path}, lines {d.line} to {d.end_line}, in the authors’ artifact</a>
      </p>
    </article>
  );
}
