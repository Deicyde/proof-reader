// What the focus graph draws for one paper, read from its edition: a card for every Lean
// declaration, the edges Lean reports between them, and the chain of uses up to the main
// result. docs/graph-pane.md says what each part is for.

import type { Declaration, Edition } from "../app/edition";
import type { FGCard, FGEdge, FGRole } from "./FocusGraph";

/** A printed number at the start of a statement: "Theorem 2.1", "Lemma 3", "Definition 4.2". */
const PRINTED = /^(Theorem|Lemma|Proposition|Corollary|Definition|Claim|Conjecture|Axiom|Example|Remark)\s+(\d+(?:\.\d+)*)\b/;

const printedNumber = (quote: string | undefined) => {
  const m = quote ? PRINTED.exec(quote.replace(/\s+/g, " ").trim()) : null;
  return m ? `${m[1]} ${m[2]}` : undefined;
};

const isProof = (d: Declaration) => d.keyword === "theorem" || d.keyword === "lemma";

/** "lean/PCP/Algebraic/ThreeColorVerifier.lean" -> "PCP/Algebraic/ThreeColorVerifier.lean". */
const shortFile = (file: string) => file.replace(/^lean\//, "");

/** File stems too general to name a part of the proof alone: the folder is said with them. */
const GENERIC = new Set(["Basic", "Defs", "Definition", "Definitions", "Main", "Core", "Lemmas", "Theorem", "Statement"]);
/** The paper is written in British English; the Lean names are American. */
const BRITISH: Record<string, string> = { color: "colour", coloring: "colouring", colorability: "colourability" };

/** People's names keep their capital. */
const NAMES = new Set(["Berlekamp", "Welch", "Hadamard", "Reed", "Solomon", "Schwartz", "Zippel"]);

const words = (stem: string) =>
  (stem.match(/[A-Z]+(?=[A-Z][a-z])|[A-Z]?[a-z]+|[A-Z]+|\d+/g) ?? [stem]).map((w) =>
    (w.length > 1 && w === w.toUpperCase()) || NAMES.has(w) ? w : BRITISH[w.toLowerCase()] ?? w.toLowerCase());

/** A Lean file in plain words: "ThreeColorVerifier.lean" -> "Three colour verifier", "Verifier/Definition.lean" -> "Verifier definition". */
export function fileWords(file: string): string {
  const parts = shortFile(file).replace(/\.lean$/, "").split("/");
  const stem = parts[parts.length - 1];
  const out = GENERIC.has(stem) && parts.length > 1 ? [...words(parts[parts.length - 2]), ...words(stem)] : words(stem);
  const text = out.join(" ").replace("Berlekamp Welch", "Berlekamp\u2013Welch").replace("low degree", "low-degree").replace("zero on grid", "zero-on-grid");
  return text.charAt(0).toUpperCase() + text.slice(1);
}

export interface FocusData {
  card(id: string): FGCard | undefined;
  /** Every edge with one of `ids` at one end. */
  edges(ids: readonly string[]): FGEdge[];
  /** From the nearest of `ids` up to the main result, each used by the next; [] at the main result; null when no chain exists. */
  route(ids: readonly string[]): string[] | null;
  /** The main result's declaration, if the paper names one. */
  main: string | null;
  /** The first passage, in reading order, that each declaration is tied to. */
  firstPassage: ReadonlyMap<string, number>;
}

export function focusData(edition: Edition): FocusData {
  const byId = new Map(edition.declarations.map((d) => [d.id, d]));
  const passageAt = new Map(edition.passages.map((p, i) => [p.id, i]));
  const results = new Map<string, string | undefined>();
  for (const claim of edition.claims) {
    const quote = edition.passages.find((p) => p.id === claim.passage)?.quote;
    for (const id of claim.lean) if (!results.has(id)) results.set(id, printedNumber(quote));
  }
  const firstPassage = new Map<string, number>();
  for (const d of edition.declarations) {
    const at = d.passages.map((p) => passageAt.get(p)).filter((i): i is number => i !== undefined);
    if (at.length) firstPassage.set(d.id, Math.min(...at));
  }
  const firstPassageOf = (d: Declaration) => firstPassage.get(d.id);

  const roleOf = (d: Declaration): FGRole => {
    if (results.has(d.id)) return "result";
    if (d.keyword === "axiom") return d.passages.length ? "step" : "helper";
    if (!isProof(d)) return "definition";
    return d.passages.length ? "step" : "helper";
  };
  const kickerOf = (d: Declaration): string | undefined => {
    if (d.keyword === "axiom") return "Axiom";
    const printed = results.get(d.id);
    if (printed) return printed;
    for (const id of d.passages) {
      const p = edition.passages.find((x) => x.id === id);
      if (p && (p.role === "states" || p.role === "defines" || p.role === "proves")) {
        const n = printedNumber(p.quote);
        if (n) return n;
      }
    }
    return undefined;
  };
  // These editions have no phrase topics. A crowded side is grouped by the Lean file each
  // declaration lives in, named in plain words ("Three colour verifier"), because the authors'
  // files follow the parts of the proof. With a single Lean file that says nothing, so the
  // paper section a declaration is first stated in names its group instead.
  const files = new Set(edition.declarations.map((d) => d.file));
  // A file whose plain name extends another's ("Binary local correction soundness") is part of
  // that one's topic, so a crowded side shows a few parts of the proof rather than every file.
  const named = [...files].map(fileWords);
  const topicOfFile = new Map([...files].map((f) => {
    const own = fileWords(f);
    const parent = named.filter((n) => n !== own && own.startsWith(`${n} `)).sort((a, b) => a.length - b.length)[0];
    return [f, parent ?? own];
  }));
  const sectionTitle = new Map((edition.reading?.outline ?? []).map((s) => [s.number, `${s.number} ${s.title}`]));
  const firstSection = (d: Declaration) => {
    const at = firstPassageOf(d);
    return at === undefined ? undefined : sectionTitle.get(edition.passages[at].section);
  };
  const cards = new Map<string, FGCard>();
  for (const d of edition.declarations) {
    // A long Lean name wraps after a dot, never inside a word.
    cards.set(d.id, {
      id: d.id,
      title: d.plain || d.id,
      name: d.id.replace(/\./g, ".\u200b"),
      role: roleOf(d),
      kicker: kickerOf(d),
      topic: files.size > 1 ? topicOfFile.get(d.file) : firstSection(d),
      section: files.size > 1 ? fileWords(d.file) : firstSection(d),
    });
  }

  // `from` uses `to`: in its proof or body, or only in its statement.
  const kind = (from: Declaration, to: string): FGEdge["kind"] =>
    from.uses_proof.includes(to) ? "proof" : from.uses_statement.includes(to) ? "statement" : undefined;

  const edges = (ids: readonly string[]): FGEdge[] => {
    const out = new Map<string, FGEdge>();
    const add = (from: string, to: string) => {
      const d = byId.get(from);
      if (!d || !byId.has(to) || from === to) return;
      out.set(`${from}>${to}`, { from, to, kind: kind(d, to) });
    };
    for (const id of ids) {
      const d = byId.get(id);
      if (!d) continue;
      for (const to of d.uses) add(id, to);
      for (const from of d.used_by) add(from, id);
    }
    return [...out.values()];
  };

  const main = edition.claims[0]?.lean.find((id) => byId.has(id)) ?? null;
  // Breadth first along "used by", so the chain is a shortest one.
  const route = (ids: readonly string[]): string[] | null => {
    if (!main) return null;
    if (ids.includes(main)) return [];
    const from = new Map<string, string | null>(ids.filter((id) => byId.has(id)).map((id) => [id, null]));
    const queue = [...from.keys()];
    while (queue.length) {
      const id = queue.shift()!;
      if (id === main) {
        const chain: string[] = [];
        for (let at: string | null = id; at && !ids.includes(at); at = from.get(at) ?? null) chain.unshift(at);
        return chain;
      }
      for (const user of byId.get(id)?.used_by ?? []) {
        if (from.has(user) || !byId.has(user)) continue;
        from.set(user, id);
        queue.push(user);
      }
    }
    return null;
  };

  return { card: (id) => cards.get(id), edges, route, main, firstPassage };
}
