# PCP reader source and extraction record

The shared `lean/` tree contains the PCP and `vendor/` paths, `PCP.lean`, project configuration, citation, README and licence files from `troyjlee/tcs-formalizations` at `a0ce13ed0fa264f051c1278e039596ce65557fa4`. A Git-blob comparison against that revision checked all 1,063 copied files, with no differing or extra files. The selected upstream paths contain `LICENSE`, `vendor/LICENSE`, and `vendor/LICENSE-CSLib`; no file named NOTICE occurs in those paths. See `vendor/UPSTREAM.json` for vendor provenance.

Each companion's `generated/lean.json` retains the 207 rows from `papers/pcp-reading-guide/generated/lean.json` (SHA-256 `c11f9771516b06f5486191d4ef2fbc1cbf9283291ae756e4f97b1ffeb93fc2f4`): 206 rows have `lean` provenance and the `PCP.np_subset_pcp` statement has `statement-compiled` provenance. Its statement was compiled as a surrogate in the guide's retained extraction; its proof was not built by that extraction and no proof-use edges or axiom report are supplied for it. The other selected proof declarations are source-read, with no extracted proof-use edges or axiom reports. The top-level provenance is deliberately `source-read` because the combined edition is not a fresh extraction. Per-row provenance remains in each JSON file. This record does not assert a new Lean build or independent review.

The five guide files are byte-identical to their files in the shared source tree. Their SHA-256 hashes are:

| Module | SHA-256 |
| --- | --- |
| `PCP.Complexity.NP` | `b23701ce674baccb03d4333ce8327e81119f55e7c1a2f02488db7787b51ee861` |
| `PCP.Verifier.Definition` | `9251c711540860428f8227a9d8e08c1e02eaf68fd7b054acdaac340f2b360f11` |
| `PCP.Complexity.CostModel` | `61004144561944c3ed8d18a6a4ad3ed22db29f34cda6e9f5f3888e3d06bff0eb` |
| `PCP.Complexity.Machine` | `640230c1838bffb7442c52575b34f9322c3da3f90fedcfd2ed57c3e1fc763dc0` |
| `PCP.Theorem` | `987a4f3993b06a078fabcc8e4c90b69c722096957e7ca43aa45c9e4e90d80f88` |
