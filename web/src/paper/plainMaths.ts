// A TeX formula as plain Unicode text, the way Physlib's API maps write maths:
//
//   x_0^2+x_0x_1        ->  x₀² + x₀x₁
//   D^2f(a)(y,y)>0      ->  D²f(a)(y, y) > 0
//
// The same rules as tools/plain_maths.py, which writes the GitHub edition, so a
// formula copied from the site reads as it does in the README. TeX the rules do
// not cover throws, and the caller falls back to what KaTeX's MathML says.

const pairs = (keys: string, values: string): Record<string, string> =>
  Object.fromEntries([...keys].map((key, i) => [key, [...values][i]]));

const SUP = pairs("0123456789+-=()ni", "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿⁱ");
const SUB = pairs("0123456789+-=()aehijklmnoprstuvx", "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ");
// A minus sign is already "−" when a script is converted: U_{-2} is U₋₂.
SUP["−"] = "⁻";
SUB["−"] = "₋";
const GLYPH: Record<string, string> = { "1/2": "½", "3/4": "¾", "1/4": "¼", "1/3": "⅓", "2/3": "⅔" };
const SYMBOL: Record<string, string> = {
  to: "→", mapsto: "↦", times: "×", in: "∈", neq: "≠", ne: "≠", le: "≤", leq: "≤", ge: "≥", geq: "≥",
  infty: "∞", lVert: "‖", rVert: "‖", lvert: "|", rvert: "|", blacksquare: "∎", partial: "∂", cdot: "·", sum: "Σ", nabla: "∇", pm: "±",
};
const LETTER: Record<string, Record<string, string>> = { mathbb: { R: "ℝ", N: "ℕ", Z: "ℤ", Q: "ℚ", C: "ℂ" } };
const GREEK_NAMES = "alpha beta gamma delta epsilon theta lambda mu nu pi rho sigma tau phi chi psi omega".split(" ");
const GREEK: Record<string, string> = Object.fromEntries(GREEK_NAMES.map((name, i) => [name, [..."αβγδεθλμνπρστφχψω"][i]]));
const RELATION = new Set([..."=<>≤≥≠→↦∈×"]);
const OPEN = "([";
const SCRIPTS = Object.values(SUP).join("") + Object.values(SUB).join("");

export class MathsError extends Error {}

/** The argument starting at i: a braced group, a command, or one character. */
function group(tex: string, i: number): [string, number] {
  while (i < tex.length && tex[i] === " ") i++;
  if (i >= tex.length) throw new MathsError(`missing argument in ${tex}`);
  if (tex[i] === "{") {
    let depth = 0;
    for (let j = i; j < tex.length; j++) {
      depth += tex[j] === "{" ? 1 : tex[j] === "}" ? -1 : 0;
      if (depth === 0) return [tex.slice(i + 1, j), j + 1];
    }
    throw new MathsError(`unbalanced braces in ${tex}`);
  }
  if (tex[i] === "\\") {
    const m = /^\\[A-Za-z]+/.exec(tex.slice(i));
    if (m) return [m[0], i + m[0].length];
  }
  return [tex[i], i + 1];
}

function script(body: string, table: Record<string, string>, mark: string): string {
  const text = plainMaths(body, false);
  if ([...text].every((ch) => Object.hasOwn(table, ch))) return [...text].map((ch) => table[ch]).join("");
  return text.length === 1 ? `${mark}${text}` : `${mark}(${text})`;
}

/** Characters of the plain text, with operators kept apart for spacing. */
function tokens(tex: string): string[] {
  const out: string[] = [];
  let i = 0;
  while (i < tex.length) {
    const ch = tex[i];
    if (ch === "\\") {
      const m = /^\\([A-Za-z]+|.)/.exec(tex.slice(i))!;
      const name = m[1];
      i += m[0].length;
      // TeX drops the spaces after a command's name.
      if (/^[A-Za-z]+$/.test(name)) while (i < tex.length && tex[i] === " ") i++;
      if (["left", "right", "big", "Big"].includes(name)) continue;
      if (name === "{" || name === "}") {
        out.push(name);
        continue;
      }
      if (name === "qquad") out.push("\u2003\u2003");
      else if ([" ", ",", ";", "quad", "!"].includes(name)) out.push(name === "!" ? "" : " ");
      else if (Object.hasOwn(SYMBOL, name)) out.push(SYMBOL[name]);
      else if (GREEK_NAMES.includes(name)) out.push(GREEK[name]);
      else if (Object.hasOwn(LETTER, name)) {
        let arg: string;
        [arg, i] = group(tex, i);
        if (!Object.hasOwn(LETTER[name], arg)) throw new MathsError(`no plain letter for \\${name}{${arg}}`);
        out.push(LETTER[name][arg]);
      } else if (["tfrac", "frac", "dfrac"].includes(name)) {
        let top: string, bottom: string;
        [top, i] = group(tex, i);
        [bottom, i] = group(tex, i);
        if (Object.hasOwn(GLYPH, `${top}/${bottom}`)) {
          out.push(GLYPH[`${top}/${bottom}`]);
          continue;
        }
        const text = `${plainMaths(top, false)}/${plainMaths(bottom, false)}`;
        const rest = tex.slice(i).trimStart();
        const closes = /^\\(right|rVert|rvert|end|qquad|quad)\b|^\\[ ,;]/.test(rest);
        // A fraction that multiplies what follows is bracketed: (c/2)y₁.
        const multiplies = rest.length > 0 && (/^[\p{L}\p{N}]/u.test(rest) || ("(\\".includes(rest[0]) && !closes));
        out.push(multiplies ? `(${text})` : text);
      } else if (name === "dot" || name === "ddot") {
        // A time derivative: \dot x is ẋ, with a combining dot above the letter.
        let arg: string;
        [arg, i] = group(tex, i);
        out.push(plainMaths(arg, false) + (name === "dot" ? "\u0307" : "\u0308"));
      } else if (name === "sqrt") {
        let arg: string;
        [arg, i] = group(tex, i);
        const text = plainMaths(arg, false);
        out.push(text.length === 1 || /^\d+$/.test(text) ? `√${text}` : `√(${text})`);
      } else if (name === "begin") {
        let env: string;
        [env, i] = group(tex, i);
        const close = `\\end{${env}}`;
        const end = tex.indexOf(close, i);
        if (end < 0) throw new MathsError(`no ${close} in ${tex}`);
        const body = tex.slice(i, end);
        i = end + close.length;
        if (!["pmatrix", "bmatrix", "matrix"].includes(env)) throw new MathsError(`no plain form for the ${env} environment`);
        const rows = body.split("\\\\").map((row) => row.split("&").map((cell) => plainMaths(cell.trim())));
        out.push("[" + rows.map((row) => "[" + row.join(", ") + "]").join(", ") + "]");
      } else {
        throw new MathsError(`no plain form for \\${name} in ${tex}`);
      }
    } else if (ch === "^" || ch === "_") {
      let arg: string;
      [arg, i] = group(tex, i + 1);
      out.push(script(arg, ch === "^" ? SUP : SUB, ch));
    } else if (ch === "{" || ch === "}") {
      i++;
    } else {
      out.push(ch === "-" ? "−" : ch);
      i++;
    }
  }
  return out;
}

const operand = (c: string) => /[\p{L}\p{N}]/u.test(c) || ")]‖|".includes(c) || SCRIPTS.includes(c);

export function plainMaths(tex: string, spaced = true): string {
  const parts = tokens(tex.replace(/\n/g, " "));
  if (!spaced) return parts.join("").trim();
  let out = "";
  for (const part of parts) {
    const before = out.replace(/ +$/, "");
    if (RELATION.has(part) || part === "+") out = `${before} ${part} `;
    else if (part === "−") {
      // Binary after an operand, otherwise a sign: (1, −1), = −t².
      const last = before.slice(-1);
      out = before + (before && operand(last) ? " − " : (!before || OPEN.includes(last) ? "" : " ") + "−");
    } else if (part === ",") out = `${before}, `;
    else if (part === ":") out = `${before}: `;
    else if (part === " ") out = out.endsWith(" ") || !out ? out : out + " ";
    else out += part;
  }
  out = out.replace(/ +/g, " ").trim().replace(/ ([.,;])$/, "$1");
  return out.replace(/\u2003\u2003 /g, "\u2003\u2003").replace(/ \u2003\u2003/g, "\u2003\u2003");
}
