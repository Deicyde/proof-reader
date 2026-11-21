# Building and checking the Theorem 7.1 wrapper

**Status of every new Lean module and every patched Lean file: NOT COMPILED.**
The return supplies complete candidate proof bodies for the extended-certificate
and cell endpoints. It contains no new Lean build, axiom audit, exported proof
or Comparator verdict. The ordinary-certificate proposition is stated but its
new proof is not supplied.

## 1. Inputs and outputs

Use the authors' source at commit
`ad53419de079eb8f95f60313473374624a348546`, with:

| Input | Required value |
|---|---|
| Lean | `leanprover/lean4:v4.33.1` |
| Mathlib | `0df444a360eaa60ab8c11dca51a86af692955474` |
| Exporter used by the supplied workflow | `leanprover/lean4export`, commit `15f6055e299ad5b89345e533cc2192f4cc00f659`, built with Lean 4.33.1 |
| Separate judge toolchain used by that workflow | `leanprover/lean4:v4.36.0` |

The comparison endpoints are:

```lean
Breakdown.theorem71_extended
Breakdown.theorem71_cell
```

Their conclusion is `Breakdown.Theorem71.ExtendedConclusion d`, defined in
`Theorem71Statements.lean`. It retains one selected parameter, its period and
approximate field, a nonzero smooth exact profile, the actual correction and
canonical gradient, a weak Hessian, the full multiplier penalty, the bound at
every time, the exact pins, and every prescribed symmetry. The predicates
`Breakdown.Theorem71Extended` and `Breakdown.Theorem71Ordinary` are statements;
the candidate extended proof is `Breakdown.Theorem71.extended`.

## 2. Install into an isolated copy

The following examples are Bash commands. Set these paths once, using absolute
paths to the unpacked return and to an isolated authors' checkout. The third
path is an unchanged copy of the supplied authors' `lean/` directory, used only
for source comparison. Do not point it at the copy being patched.

```bash
RETURN_ROOT=/absolute/path/to/unpacked/return
NS_ROOT=/absolute/path/to/isolated/navier-stokes
ORIGINAL_LEAN=/absolute/path/to/unchanged/authors/lean
OUT_DIR=/absolute/path/to/theorem71-results
mkdir -p "$OUT_DIR"

python3 "$RETURN_ROOT/scripts/install_wrapper.py" "$NS_ROOT/lean"
python3 "$RETURN_ROOT/scripts/install_wrapper.py" "$NS_ROOT/lean" --apply
python3 "$RETURN_ROOT/scripts/validate_sources.py" "$NS_ROOT/lean" \
  --original "$ORIGINAL_LEAN" > "$OUT_DIR/source-validation.json"
```

The first installer invocation is read only. The second verifies all inputs
before writing, applies the three exact patches, installs thirteen Lean
modules and two configurations, and registers their Lake libraries. It does
not change the original default targets. It writes
`theorem71-install-receipt.json` in the patched Lean directory. It accepts the
exact already-installed state, but refuses altered source, mixed patch states
and different existing wrapper files. Its three source hashes and expected
patched hashes are in `patches/keep-witness-pins.json`.

The patches retain the existing theorem types. They add:

- `Breakdown.Cert.extendedSigmaProfileOfHeld_keep` in `Breakdown/Cert/ExtendedSigmaProfileOfHeld.lean`;
- `Breakdown.weakPeriodicSimilarityProfileOf_sigma_keep` in `Breakdown/Cert/Rescale.lean`;
- `Breakdown.WeakProfile.weakOrbitOfParts_keep` in `Breakdown/Weak/OrbitOfParts.lean`.

All original exports become corollaries that discard the additional witnesses.
The authors' full source is intentionally not included in this return.

## 3. Compile the new targets and inspect axioms

Run under the pinned authors' toolchain. Reuse the dependency setup and cache
steps in the supplied workflow. Keep the shell's failure handling enabled;
an unsuccessful build must stop the sequence.

```bash
set -euo pipefail
cd "$NS_ROOT/lean"
lake --version > "$OUT_DIR/build-toolchain.txt"
lake build Theorem71Challenge Theorem71Solution Theorem71Control \
  Theorem71Norms Theorem71Axioms > "$OUT_DIR/build.log" 2>&1
lake env lean Theorem71Axioms.lean > "$OUT_DIR/axioms.log" 2>&1
python3 "$RETURN_ROOT/scripts/check_axioms.py" "$OUT_DIR/axioms.log" \
  > "$OUT_DIR/axiom-check.json"
```

The challenge, solution and control intentionally declare the same endpoint
name in separate modules. Build them as separate targets; do not make an
aggregate module that imports more than one of those three. `Theorem71Axioms`
imports only the solution and the norm translations.

The axiom check requires output for both selected endpoints, allows only
`propext`, `Quot.sound` and `Classical.choice`, checks every additional axiom
report present, and rejects Lean error messages. It is a check of an actual
compiler log once that log exists; the fixtures in this return are explicitly
synthetic tests of the parser.

### Module inventory

| Module | Purpose | Compilation status |
|---|---|---|
| `Theorem71Statements` | Readable physical contract and ordinary proposition | NOT COMPILED |
| `Theorem71KeepTypes` | Weak profile with explicit witnesses | NOT COMPILED |
| `Theorem71Keep` | Concrete analytic nodes, selected witness, energy and pins | NOT COMPILED |
| `Theorem71Transport` | Same orbit, actual correction, weak derivatives, finiteness and symmetries | NOT COMPILED |
| `Theorem71Smooth` | Smooth profile at the retained period and identity isometry | NOT COMPILED |
| `Theorem71GradientBound` | Continuity of the physical gradient integral and bound at every time | NOT COMPILED |
| `Theorem71Assembly` | Complete candidate extended proof | NOT COMPILED |
| `Theorem71Cells` | Cell constructor, zero correction pins and decay-field adapter | NOT COMPILED |
| `Theorem71Norms` | Squared norm, Sobolev constant and symmetry translations | NOT COMPILED |
| `Theorem71Challenge` | Two exact statement endpoints with ordinary proof terms | NOT COMPILED |
| `Theorem71Solution` | Two solution endpoints | NOT COMPILED |
| `Theorem71Control` | Deliberate endpoint type mismatch | NOT COMPILED |
| `Theorem71Axioms` | Endpoint checks and axiom-print commands | NOT COMPILED |

Elaboration may require local interface or tactic corrections. Preserve the
contract while fixing them: in particular the same parameter and actual field,
the original multiplier penalty, the finite weighted integral and the bound at
every time. Adding a hypothesis that asserts one of these conclusions would
change the requested theorem.

## 4. Export with Lean 4.33.1

The supplied workflow builds the source and exporter with Lean 4.33.1, then
judges saved exports with Lean 4.36.0. Reuse that separation. Do not change the
authors' source toolchain to the judge version.

Set `EXPORTER` to the absolute path of the exporter built by the workflow at
the pin above. These commands select the same primitive roots used by the
packet and add the new targets. Run them from the patched authors' Lean tree.

```bash
EXPORTER=/absolute/path/to/lean4export/.lake/build/bin/lean4export
cd "$NS_ROOT/lean"
primitive_roots=(
  Quot Quot.mk Quot.lift Quot.ind
  propext Quot.sound Classical.choice
  Nat.add Nat.sub Nat.mul Nat.pow Nat.gcd Nat.div Nat.mod Nat.beq Nat.ble
  Nat.land Nat.lor Nat.xor Nat.shiftLeft Nat.shiftRight
  String.ofList Char.ofNat List eagerReduce Nat String String.mk Char
  optParam autoParam semiOutParam outParam
)
theorem71_roots=(Breakdown.theorem71_extended Breakdown.theorem71_cell)

lake env "$EXPORTER" Theorem71Challenge -- \
  "${primitive_roots[@]}" "${theorem71_roots[@]}" \
  > "$OUT_DIR/challenge.export" 2> "$OUT_DIR/export-challenge.log"
lake env "$EXPORTER" Theorem71Solution -- \
  "${primitive_roots[@]}" "${theorem71_roots[@]}" \
  > "$OUT_DIR/solution.export" 2> "$OUT_DIR/export-solution.log"
lake env "$EXPORTER" Theorem71Control -- \
  "${primitive_roots[@]}" Breakdown.theorem71_extended \
  > "$OUT_DIR/control.export" 2> "$OUT_DIR/export-control.log"
sha256sum "$OUT_DIR/challenge.export" "$OUT_DIR/solution.export" \
  "$OUT_DIR/control.export" > "$OUT_DIR/exports.sha256"
```

## 5. Judge the saved exports

Use a separate judge directory with `leanprover/lean4:v4.36.0` and the sandbox
setup from the supplied `ours/navier-stokes-comparator.yml`. The workflow
already documents the required `bubblewrap` setup. The four checkers must be
available on `PATH`; otherwise nothing has been independently checked.

```bash
JUDGE_ROOT=/absolute/path/to/separate/theorem71-judge
mkdir -p "$JUDGE_ROOT"
printf '%s\n' 'leanprover/lean4:v4.36.0' > "$JUDGE_ROOT/lean-toolchain"
cd "$JUDGE_ROOT"
judge_bin="$(dirname "$(elan which lake)")"
export PATH="$judge_bin:$PATH"
lake --version > "$OUT_DIR/judge-toolchain.txt"
for checker in leanchecker-paranoid nanoda_bin con-leche con-ron; do
  command -v "$checker"
done > "$OUT_DIR/checkers.txt"

if lake comparator --config "$RETURN_ROOT/wrapper/comparator-theorem71.json" \
    --challenge-from-export "$OUT_DIR/challenge.export" \
    --solution-from-export "$OUT_DIR/solution.export" \
    > "$OUT_DIR/positive.log" 2>&1; then
  printf '0\n' > "$OUT_DIR/positive.exit"
else
  printf '%s\n' "$?" > "$OUT_DIR/positive.exit"
fi

if lake comparator --config "$RETURN_ROOT/wrapper/comparator-theorem71-control.json" \
    --challenge-from-export "$OUT_DIR/control.export" \
    --solution-from-export "$OUT_DIR/solution.export" \
    > "$OUT_DIR/control.log" 2>&1; then
  printf '0\n' > "$OUT_DIR/control.exit"
else
  printf '%s\n' "$?" > "$OUT_DIR/control.exit"
fi

python3 "$RETURN_ROOT/scripts/check_comparator_logs.py" "$OUT_DIR" \
  > "$OUT_DIR/comparator-receipt.json"
```

Expected positive outcome: exit zero with the configured independent checkers
run. Expected control outcome: exit one and this exact diagnostic:

```text
Challenge and solution theorem statement do not match: 'Breakdown.theorem71_extended'
```

The control changes the extended conclusion from `P` to `P ∧ True`. It tests
statement mismatch detection. It does not test whether the certificate
hypothesis is necessary. Infrastructure failures or different diagnostics are
not accepted by the receipt parser as a successful control.

The no-admission rule applies to the challenge too. Its ordinary proof goes
through the common implementation, and it imports no solution module. This
checks a fixed statement and replays proof terms; it does not provide a second,
independent implementation of the PDE argument. Freeze the readable statement
and its definition closure before accepting a replacement solution.

## 6. Incorporating this into the existing workflow

The original workflow's tracked-source check expects no changes outside its
Lake harness. These three intentional source patches must therefore be
accounted for explicitly. Keep the upstream checkout at the pinned commit,
verify its original hashes, record the exact patch and its resulting hashes,
then verify the patched state before and after building. Do not simply disable
the source-integrity check. Add the five build targets above and the three
exports to the existing build/export job; run the two new configurations in
its separate judge job. Keep its compiled-artifact and dependency hash records.

Preserve the build, axiom, export and Comparator logs together with the source,
configuration, patch and export hashes. The source checks in `validation/`
were performed locally; none is a substitute for these pending compiler and
replay results. A numerical certificate remains a separate input, outside the
claim of this conditional wrapper.
