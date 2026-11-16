# PCP reader source and extraction record

The shared `lean/` tree contains the PCP and `vendor/` paths, `PCP.lean`, project configuration, citation, README and licence files from `troyjlee/tcs-formalizations` at `a0ce13ed0fa264f051c1278e039596ce65557fa4`. A Git-blob comparison against that revision checked all 1,063 copied files, with no differing or extra files. The selected upstream paths contain `LICENSE`, `vendor/LICENSE`, and `vendor/LICENSE-CSLib`; no file named NOTICE occurs in those paths. See `vendor/UPSTREAM.json` for vendor provenance.

Each companion's `generated/lean.json` is Lean's report on compiled modules. On 16 November 2026 a GitHub Actions run in this repository ([run 43790700983](https://github.com/wcook04/proof-reader/actions/runs/43790700983), commit `b50cf8b632b4c0bf55060af8c2294823ee074ba0`, workflow `.github/workflows/pcp-extract.yml`) fetched Mathlib's compiled files with `lake exe cache get`, compiled the 71 PCP modules the three companions list with `lake build` at the project's toolchain (Lean 4.35.0-rc2; the log ends "Build completed successfully (4041 jobs)"), and ran `tools/extract_built.py` for each companion. That tool uses a module only when the compiled project's source is byte-identical to the copy under `papers/pcp-full-argument/lean/`. Every row has `lean` provenance, including `PCP.np_subset_pcp`, whose proof was built in this run. Dependencies, the split between statement and proof uses, and axiom reports come from those compiled modules. Across the three companions Lean reports no axioms beyond `propext`, `Classical.choice` and `Quot.sound`.

| Report | Modules | Rows | SHA-256 |
| --- | --- | --- | --- |
| `papers/pcp-exposition/generated/lean.json` | 26 | 890 | `598e8a5d5c59924a3818838f4831d1232f138ee19cc49ccfef56ac95dd879440` |
| `papers/pcp-full-argument/generated/lean.json` | 69 | 1792 | `a0d304ad2df6105e9eae6bf40129f934b80a8586126ac759616ba1967a5a0bb5` |
| `papers/pcp-specialist/generated/lean.json` | 26 | 815 | `e30848ba23623b6db744829751234c9aee1d865fe522ea2b807a82b863bcc2af` |

The original guide's page (`papers/pcp-reading-guide`) keeps its earlier extraction: 206 rows with `lean` provenance and a statement-only compilation of `PCP.np_subset_pcp`.

## Comparator on the headline statements

On 16 November 2026 a second GitHub Actions run ([run 43868208176](https://github.com/wcook04/proof-reader/actions/runs/43868208176), commit `027be095d4715b0d9bbd243debf08b8d5ad6907c`, workflow `.github/workflows/pcp-comparator.yml`) ran `lake comparator`, the judge shipped with the project's toolchain, inside its `bubblewrap` sandbox. The challenge is `comparator/Challenge.lean`: it imports `PCP.Complexity.NP`, `PCP.Complexity.Machine` and `Complexitylib.Classes.NP`, which define the words the statements use, and no proof. It states three theorems under the authors' own names, each copied from their source, with `sorry` for a proof:

| Statement | Authors' source |
| --- | --- |
| `PCP.np_subset_pcp` | `PCP/Theorem.lean`, lines 25 to 33 |
| `PCP.pcp_subset_np_concrete` | `PCP/ReverseConcrete.lean` |
| `PCP.ReferenceNP.inNP_iff_mem` | `PCP/Complexity/ReferenceNPConverse.lean` |

The solution, `comparator/Solution.lean`, only imports the authors' modules, so the declarations compared are the authors' own. Comparator reported "Lean default kernel accepts the solution" and "Your solution is okay!", with `propext`, `Quot.sound` and `Classical.choice` as the permitted axioms. A control, `comparator/negative/Challenge.lean`, restates the forward theorem with soundness 1/3 in place of 1/2; Comparator refused it with "Challenge and solution theorem statement do not match: 'PCP.np_subset_pcp'". `comparator/receipt.json` keeps the outputs and file hashes.

This was Comparator's standard mode. An earlier attempt in `--paranoid` mode, which adds further independent checkers, was stopped after 44 minutes without a verdict and is not claimed. Comparator establishes that the authors' proofs prove exactly these statements from the permitted axioms. The definitions the statements use are the authors' own, imported and not restated, and nothing here says the statements mean what the papers say.

This record says that Lean compiled these modules in that run and what it reported. It is not a review of the mathematics, and it does not establish that the papers' prose and the Lean have the same meaning. The links, plain titles and notes were made with AI and have not been reviewed by the authors; comparisons of statements with their Lean remain held.

The five guide files are byte-identical to their files in the shared source tree. Their SHA-256 hashes are:

| Module | SHA-256 |
| --- | --- |
| `PCP.Complexity.NP` | `b23701ce674baccb03d4333ce8327e81119f55e7c1a2f02488db7787b51ee861` |
| `PCP.Verifier.Definition` | `9251c711540860428f8227a9d8e08c1e02eaf68fd7b054acdaac340f2b360f11` |
| `PCP.Complexity.CostModel` | `61004144561944c3ed8d18a6a4ad3ed22db29f34cda6e9f5f3888e3d06bff0eb` |
| `PCP.Complexity.Machine` | `640230c1838bffb7442c52575b34f9322c3da3f90fedcfd2ed57c3e1fc763dc0` |
| `PCP.Theorem` | `987a4f3993b06a078fabcc8e4c90b69c722096957e7ca43aa45c9e4e90d80f88` |

## Revised manuscript correspondence

The companion texts were refreshed from the accepted manuscripts with SHA-256 `1d09db7bfda9d8f7cb2a4b8cf14421c8bf8b2edb7d0391655fb8715c1dce1588` (long), `c1f177680bbe01f2e4b7bdee82cd9fedf276cecb9ae0f258a2b6e5fe3115c377` (specialist), and `4fc575eb9827c6253c457bcae3a55547a15f709efacbc3f65443cdf2c84fe303` (exposition). The reader copies differ only in companion-link targets. The source quotations and block anchors were rebound to those texts.

A source-level correspondence review found that some previous links selected downstream theorems for intermediate claims. They now identify the actual local declarations for line characterization, bivariate and point-line steps, Hadamard row decoding and correction, the verifier's proof tables, the finite-machine reduction, and resource accounting. In particular, the specialist's binary polynomial decoding passage now selects the conclusion following equation (11), rather than the preceding Hadamard-row discussion. New rows were transcribed from the same pinned Lean tree and marked `source-read`; they have no extracted proof dependencies or axiom reports. Exact quotation and declaration-location checks do not establish elaborated theorem equivalence, and the comparison hold remains in force.

The reading-copy highlighter requires a quotation within one supported Markdown block. Where the matching assertion appears only in a display formula, this edition omits the direct passage link rather than attach a setup or a different claim. The associated declarations remain in the statement index and the manuscript retains its inline source links. The `Proof` structure is omitted from this selected reader dataset: the existing graph puts structures on a separate shelf, and a claim edge to the structure does not render. It remains available in the unchanged source tree and the manuscript’s inline source link. These selected links are entry points into the sources, not exhaustive coverage of each passage.
