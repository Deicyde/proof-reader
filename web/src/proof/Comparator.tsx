// What Comparator checked for a declaration: the run's result, the challenge statement it
// compiled separately, the run's files and the rejected control. Read from the build's
// `comparator` data, which papers/<slug>/paper.toml points at a folder of run files.
// Kept apart from the comparison of the paper with the Lean, which is a different question.

import { useState } from "react";
import type { ComparatorEvidence, Declaration, Edition } from "../app/edition";
import { DeclLink, LeanCode, useFileLines, type LeanActions } from "../lean/code";

const list = (items: string[]) => (items.length < 2 ? items.join("") : `${items.slice(0, -1).join(", ")} and ${items[items.length - 1]}`);

const MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

/** 2026-11-16 as 16 November 2026, the same in every browser. */
export function longDate(iso: string): string {
  const [year, month, day] = iso.split("-").map(Number);
  return month && day ? `${day} ${MONTHS[month - 1]} ${year}` : iso;
}

/** The declarations on this page that Comparator checked, in the run's order. */
export function comparatorChecked(edition: Edition): Declaration[] {
  const evidence = edition.comparator;
  if (!evidence) return [];
  return Object.keys(evidence.theorems)
    .map((name) => edition.declarations.find((d) => d.id === name))
    .filter((d): d is Declaration => !!d);
}

function Statement({ edition, evidence, d, names, act }: { edition: Edition; evidence: ComparatorEvidence; d: Declaration; names: ReadonlySet<string>; act: LeanActions }) {
  const target = evidence.theorems[d.id];
  // Padded so the line numbers are the challenge file's own.
  const lines = useFileLines("\n".repeat(target.first - 1) + target.statement);
  return (
    <div className="decl__code cmp__code" tabIndex={0} aria-label={`The challenge statement of ${d.id}`}>
      <LeanCode paper={edition.slug} lines={lines} from={target.first} to={target.last} names={names} self={d.id} act={act} />
    </div>
  );
}

const lean = (toolchain: string) => toolchain.replace(/^.*:v?/, "Lean ");

/** A closed fold under a declaration's axioms, for the theorems Comparator checked. */
export function ComparatorFold({ edition, d, names, act }: { edition: Edition; d: Declaration; names: ReadonlySet<string>; act: LeanActions }) {
  const [open, setOpen] = useState(false);
  const evidence = edition.comparator;
  const target = evidence?.theorems[d.id];
  if (!evidence || !target) return null;
  const outside = { target: "_blank", rel: "noopener noreferrer" } as const;
  return (
    <section className="cmp" data-comparator={d.id} aria-label={`Comparator evidence for ${d.id}`}>
      <button type="button" className="decl__fold cmp__fold" aria-expanded={open} onClick={() => setOpen(!open)}>
        <span aria-hidden="true">{open ? "▼" : "▶"}</span> Comparator evidence
      </button>
      {open && (
        <div className="cmp__body">
          <p className="cmp__result">
            <b>Passed</b>, {longDate(evidence.date)}, in one GitHub Actions run: sandboxed with {evidence.sandbox}, checked by the {evidence.kernel} on {lean(evidence.toolchain)}.
            {evidence.paranoid === "not completed" && <> Comparator’s <code className="cmp__flag">--paranoid</code> mode was not completed.</>}
          </p>
          <p className="cmp__what">
            Comparator accepted the solution’s proof of <code>{d.id}</code> against this separately compiled challenge statement, using only the permitted axioms {list(evidence.permitted_axioms)}.
          </p>
          <Statement edition={edition} evidence={evidence} d={d} names={names} act={act} />
          <p className="cmp__file"><a href={target.url} {...outside}>Challenge.lean, lines {target.first} to {target.last}</a></p>
          <p className="cmp__links">
            <a href={evidence.links.solution} {...outside}>Solution</a>
            <a href={evidence.links.receipt} {...outside}>Run receipt</a>
            <a href={evidence.links.config} {...outside}>Run configuration</a>
            <a href={evidence.run} {...outside}>GitHub Actions run</a>
          </p>
          <p className="cmp__control">
            Rejected control: Comparator rejected <a href={evidence.links.control} {...outside}>a challenge</a> with {evidence.control.change}.
          </p>
          <p className="cmp__scope">
            The challenge imports the definitions its statements use from the authors’ modules. Comparator does not test whether a statement means what the {edition.paper.noun || "paper"} says
            {d.fidelity ? <>; the comparison of the {edition.paper.noun || "paper"} with the Lean above is that separate question.</> : "."}
          </p>
        </div>
      )}
    </section>
  );
}

/** For the index at the back: the statements Comparator checked, each a way to its declaration. */
export function ComparatorIndex({ edition, act }: { edition: Edition; act: LeanActions }) {
  const checked = comparatorChecked(edition);
  if (!checked.length) return null;
  const evidence = edition.comparator!;
  return (
    <>
      <h3 id="comparator">{checked.length === 1 ? "One statement" : `${checked.length} statements`} checked by Comparator</h3>
      <p>
        Comparator accepted the authors’ proofs of{" "}
        {checked.map((d, i) => (
          <span key={d.id}>{i > 0 && (i === checked.length - 1 ? " and " : ", ")}<DeclLink paper={edition.slug} name={d.id} act={act} className="declname" /></span>
        ))}{" "}
        against a separately compiled challenge, on {longDate(evidence.date)}. Each declaration’s Comparator evidence opens beneath its axiom report.
      </p>
    </>
  );
}
