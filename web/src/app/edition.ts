// The data one paper's page reads. tools/paper.py writes it; nothing here is
// computed in the browser that could differ from the checked build.

export interface Rect extends Array<number> {}

export interface Passage {
  id: string;
  section: string;
  role: "states" | "defines" | "proves" | "explains" | "uses" | "mentions" | "mirrors";
  /** It is a line of code in the paper, not a sentence. */
  code?: boolean;
  quote: string;
  lean: string[];
  /** Null for Markdown; source_lines give its location. */
  page: number | null;
  last_page: number | null;
  rects: number[][];
  source_quote?: string;
  source_lines?: [number, number];
  source_block?: string;
  anchor?: { heading: string; block: number };
  /** The exact Lean lines this passage describes, when it is narrower than the declaration. */
  lines?: [number, number];
}

export interface OutlineEntry {
  id: string;
  number: string;
  title: string;
  level: number;
  ties: number;
  /** The PDF page the section starts on. */
  page: number | null;
}

/** A Lean name printed in the paper, found by matching words at build time. */
export interface Mention {
  name: string;
  page: number;
  rect: number[];
}

export interface Claim {
  id: string;
  title: string;
  section: string;
  passage: string;
  lean: string[];
}

export interface Declaration {
  id: string;
  /** What a person calls it. The raw name stays small beside this, and in the code. */
  plain: string;
  keyword: string;
  kind: string;
  type: string;
  file: string;
  line: number;
  end_line: number;
  lines: number;
  /** The last line of the statement; what follows is the proof or body. */
  statement_end: number;
  /** The authors' block comment directly above, as first and last line. */
  comment: [number, number] | null;
  uses: string[];
  uses_statement: string[];
  uses_proof: string[];
  used_by: string[];
  used_by_statement: string[];
  used_by_proof: string[];
  axioms: string[];
  standard_axioms: string[];
  /** Where this declaration's facts come from. */
  provenance?: "lean" | "statement-compiled" | "source-read";
  /** The declaration's doc comment, as Lean records it. */
  doc?: string | null;
  passages: string[];
  note: { text: string; because: string[] } | null;
  /** How the paper's statement stands to this Lean, compared with AI; absent before it was run. */
  fidelity?: Fidelity | null;
}

export type Verdict = "same" | "stronger" | "weaker" | "different";

export interface Fidelity {
  verdict: Verdict;
  text: string;
  /** Passage ids the comparison reads. */
  because: string[];
  /** Names of checks, written for this page, that Lean ran against the authors' file. */
  checks: string[];
}

export interface Check {
  name: string;
  keyword: "theorem" | "def";
  file: string;
  line: number;
  end_line: number;
  code: string;
  doc: string;
  axioms: string[];
  status: "checked";
}

export interface Edition {
  schema: 1;
  slug: string;
  source?: { kind: "pdf" | "markdown"; file: string; sha256: string };
  credit?: { text?: string };
  paper: {
    title: string;
    short_title: string;
    authors: string[];
    venue: string;
    doi: string;
    url: string;
    pdf?: string;
    markdown?: string;
    licence: string;
    licence_url: string;
    /** What the page calls the authors' text: "paper" unless paper.toml says otherwise, as "guide". */
    noun?: string;
    /** Whether the page shows Proof Reader's own films; off unless paper.toml says films = true. */
    films?: boolean;
    pages: number;
    sizes: [number, number][];
    crop: [number, number, number, number] | null;
  };
  lean: {
    modules: string[];
    source: string;
    source_name: string;
    licence: string;
    scope: string;
    /** Where one declaration's lines can be read: {path}, {line} and {end} are filled in. */
    source_lines?: string;
    toolchain: string;
    /** Null when the Lean facts were read from the source instead of produced by Lean. */
    version: string | null;
    /** Absent or "lean": names, lines and uses are the output of `paper.py extract`. "source-read": read from the authors' source by hand, pending extraction. */
    provenance?: { kind: "lean" | "source-read"; text?: string };
    files: Record<string, string>;
  };
  claims: Claim[];
  sheets?: Sheet[];
  passages: Passage[];
  mentions: Mention[];
  declarations: Declaration[];
  /** Lean proofs written for this page, which Lean accepted against the authors' file. */
  checks?: Check[];
  /** Which sections hold ties, in reading order. */
  coverage: { sections: string[]; ties: number };
  /** Present when the paper has a reading copy, which reading.html holds. */
  reading: { outline: OutlineEntry[]; words: number; formulas: number; pages: number } | null;
  analytics: {
    declarations: number;
    linked_to_paper: number;
    not_linked: string[];
    axioms: string[];
    resting_on_axioms: Record<string, string[]>;
    free_of_axioms: string[];
    standard_axioms: Record<string, string[]>;
    sorry: string[];
    proof_lines: number;
    pages_with_links: number[];
    fidelity?: { required: string[]; same: string[]; stronger: string[]; weaker: string[]; different: string[]; refuted_by_check: string[] };
  };
}

/** One linked sentence and its Lean lines, chosen in paper.toml and cut out by the build. */
/** One entry of a statement sheet: a declaration and the authors' sentences that read it. */
export interface SheetEntry {
  id: string;
  prose: string[];
  reading: "authors" | "note" | "none";
}

/** A claim's statement sheet, computed by the build from the Lean dependencies and the links. */
export interface Sheet {
  claim: string;
  title: string;
  heads: SheetEntry[];
  entries: SheetEntry[];
  explained: number;
  total: number;
  boundary: { name: string; used_by: string[] }[];
}

export interface ShelfExample {
  id: string;
  /** The passage's role in links.json: "proves", "states" and so on. */
  role?: string;
  section: string;
  page_label: string;
  source_lines?: [number, number] | null;
  before: string;
  quote: string;
  after: string;
  name: string;
  plain: string;
  keyword: string;
  file: string;
  decl_first: number;
  decl_last: number;
  first: number;
  last: number;
  code: { n: number; text: string }[];
}

export interface ShelfItem {
  slug: string;
  title: string;
  short_title?: string;
  authors: string[];
  venue: string;
  source_kind?: "pdf" | "markdown";
  noun?: string;
  declarations: number;
  lean?: { files: number; lines: number; version: string; axioms: number; sorry: number };
  linked?: number;
  example?: ShelfExample | null;
  examples?: ShelfExample[];
}

const base = import.meta.env.BASE_URL;

export const paperFile = (slug: string, name: string) => `${base}papers/${slug}/${name}`;

async function json<T>(url: string): Promise<T> {
  const response = await fetch(url);
  if (!response.ok) throw new Error(`${url}: ${response.status}`);
  return (await response.json()) as T;
}

export async function loadEdition(slug: string): Promise<Edition> {
  const edition = await json<Edition>(paperFile(slug, "edition.json"));
  return { ...edition, mentions: [], lean: { ...edition.lean, files: {} } };
}

/** What only the Lean page, the PDF and a search need, kept out of the first screen. */
export const loadSource = (slug: string) => json<{ files: Record<string, string>; mentions: Mention[] }>(paperFile(slug, "source.json"));
export const loadShelf = () => json<{ papers: ShelfItem[] }>(`${base}papers/index.json`);

/** True when the page carries comparisons of the paper's statements with the Lean. */
/** True when the page's declarations, lines, uses and axioms are Lean's own output on the authors' files. */
export const fromLean = (edition: Edition) => (edition.lean.provenance?.kind ?? "lean") === "lean";

/** One sentence on where the Lean facts came from, for credits and the account of how the page was made. */
export const leanOrigin = (edition: Edition) => fromLean(edition)
  ? `Lean from the authors’ artifact, built here on Lean ${edition.lean.version}.`
  : "Lean files from the authors’ repository, unchanged. Lean has not been run on them for this page: the declarations, lines and uses shown were read from the source with AI, and no axioms are reported.";

/** One plain phrase for where a declaration's facts come from. */
export const declOrigin = (edition: Edition, d: Declaration) => {
  const kind = d.provenance ?? (fromLean(edition) ? "lean" : "source-read");
  return kind === "lean" ? `read by Lean ${edition.lean.version}`
    : kind === "statement-compiled" ? `statement compiled by Lean ${edition.lean.version}; proof not built in that extraction`
      : "read from the source by hand, with AI";
};

/** The word for the authors' text, as in "In the guide". */
export const noun = (edition: Edition) => edition.paper.noun || "paper";

export const hasComparisons = (edition: Edition) => edition.declarations.some((d) => !!d.fidelity);

/** Source coordinates stay separate from the Lean lines a passage describes. */
export const passageLocation = (passage: Passage) => passage.source_lines
  ? passage.source_lines[0] === passage.source_lines[1] ? `source line ${passage.source_lines[0]}` : `source lines ${passage.source_lines[0]} to ${passage.source_lines[1]}`
  : `page ${passage.page}`;
