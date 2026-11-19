"""Write a TeX formula as plain Unicode text, the way Physlib's API maps write maths.

    x_0^2+x_0x_1        ->  x₀² + x₀x₁
    D^2f(a)(y,y)>0      ->  D²f(a)(y, y) > 0
    \\tfrac12C\\lVert x-a\\rVert^2  ->  ½C‖x − a‖²

The text reads the same in a Markdown file, on a rendered page and in the clipboard.
It covers the TeX the papers here use; anything else stops with an error rather than
being guessed.
"""
from __future__ import annotations

import re

SUP = dict(zip("0123456789+-=()niT", "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿⁱᵀ"))
SUB = dict(zip("0123456789+-=()aehijklmnoprstuvx", "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ"))
# A minus sign is already "−" when a script is converted: U_{-2} is U₋₂.
SUP["−"], SUB["−"] = "⁻", "₋"
GLYPH = {("1", "2"): "½", ("3", "4"): "¾", ("1", "4"): "¼", ("1", "3"): "⅓", ("2", "3"): "⅔"}
SYMBOL = {
    "to": "→", "mapsto": "↦", "times": "×", "in": "∈", "neq": "≠", "ne": "≠", "le": "≤",
    "leq": "≤", "ge": "≥", "geq": "≥", "infty": "∞", "lVert": "‖", "rVert": "‖", "lvert": "|",
    "rvert": "|", "blacksquare": "∎", "partial": "∂", "cdot": "·", "sum": "Σ", "nabla": "∇", "pm": "±",
    "cos": "cos",
}
LETTER = {"mathbb": {"R": "ℝ", "N": "ℕ", "Z": "ℤ", "Q": "ℚ", "C": "ℂ"}}
GREEK = dict(zip("alpha beta gamma delta epsilon theta lambda mu nu pi rho sigma tau phi chi psi omega".split(),
                 "αβγδεθλμνπρστφχψω"))
RELATION = set("=<>≤≥≠→↦∈×")
OPEN = "(["


class MathsError(ValueError):
    pass


def group(tex: str, i: int) -> tuple[str, int]:
    """The argument starting at i: a braced group, a command, or one character."""
    while i < len(tex) and tex[i] == " ":
        i += 1
    if i >= len(tex):
        raise MathsError(f"missing argument in {tex!r}")
    if tex[i] == "{":
        depth, j = 0, i
        while j < len(tex):
            depth += {"{": 1, "}": -1}.get(tex[j], 0)
            if depth == 0:
                return tex[i + 1:j], j + 1
            j += 1
        raise MathsError(f"unbalanced braces in {tex!r}")
    if tex[i] == "\\":
        m = re.match(r"\\[A-Za-z]+", tex[i:])
        if m:
            return m[0], i + len(m[0])
    return tex[i], i + 1


def script(body: str, table: dict, mark: str) -> str:
    text = convert(body, spaced=False)
    if all(ch in table for ch in text):
        return "".join(table[ch] for ch in text)
    return f"{mark}{text}" if len(text) == 1 else f"{mark}({text})"


def tokens(tex: str) -> list[str]:
    """Characters of the plain text, with operators kept apart for spacing."""
    out: list[str] = []
    i = 0
    while i < len(tex):
        ch = tex[i]
        if ch == "\\":
            m = re.match(r"\\([A-Za-z]+|.)", tex[i:])
            name = m[1]
            i += len(m[0])
            if name.isalpha():
                # TeX drops the spaces after a command's name.
                while i < len(tex) and tex[i] == " ":
                    i += 1
            if name in ("left", "right", "big", "Big"):
                continue
            if name in "{}":
                out.append(name)
                continue
            if name == "qquad":
                out.append("  ")
            elif name in (" ", ",", ";", "quad", "!"):
                out.append(" " if name != "!" else "")
            elif name in SYMBOL:
                out.append(SYMBOL[name])
            elif name in GREEK:
                out.append(GREEK[name])
            elif name in LETTER:
                arg, i = group(tex, i)
                if arg not in LETTER[name]:
                    raise MathsError(f"no plain letter for \\{name}{{{arg}}}")
                out.append(LETTER[name][arg])
            elif name in ("tfrac", "frac", "dfrac"):
                top, i = group(tex, i)
                bottom, i = group(tex, i)
                if (top, bottom) in GLYPH:
                    out.append(GLYPH[(top, bottom)])
                    continue
                text = f"{convert(top, spaced=False)}/{convert(bottom, spaced=False)}"
                rest = tex[i:].lstrip()
                closes = re.match(r"\\(right|rVert|rvert|end|qquad|quad)\b|\\[ ,;]", rest)
                # A fraction that multiplies what follows is bracketed: (c/2)y₁.
                multiplies = bool(rest) and (rest[0].isalnum() or (rest[0] in "(\\" and not closes))
                out.append(f"({text})" if multiplies else text)
            elif name in ("dot", "ddot"):
                # A time derivative: \dot x is ẋ, with a combining dot above the letter.
                arg, i = group(tex, i)
                out.append(convert(arg, spaced=False) + ("\u0307" if name == "dot" else "\u0308"))
            elif name == "sqrt":
                arg, i = group(tex, i)
                text = convert(arg, spaced=False)
                out.append(f"√{text}" if len(text) == 1 or text.isdigit() else f"√({text})")
            elif name == "begin":
                env, i = group(tex, i)
                end = tex.index(f"\\end{{{env}}}", i)
                body, i = tex[i:end], end + len(f"\\end{{{env}}}")
                if env not in ("pmatrix", "bmatrix", "matrix"):
                    raise MathsError(f"no plain form for the {env} environment")
                rows = [[convert(c.strip()) for c in r.split("&")] for r in body.split("\\\\")]
                out.append("[" + ", ".join("[" + ", ".join(r) + "]" for r in rows) + "]")
            else:
                raise MathsError(f"no plain form for \\{name} in {tex!r}")
        elif ch in "^_":
            arg, i = group(tex, i + 1)
            out.append(script(arg, SUP if ch == "^" else SUB, ch))
        elif ch in "{}":
            i += 1
        else:
            out.append("−" if ch == "-" else ch)
            i += 1
    return out


def convert(tex: str, spaced: bool = True) -> str:
    parts = tokens(tex.replace("\n", " "))
    if not spaced:
        return "".join(parts).strip()
    out = ""
    for k, part in enumerate(parts):
        before = out.rstrip(" ")
        if part in RELATION or part == "+":
            out = before + f" {part} "
        elif part == "−":
            # Binary after an operand, otherwise a sign: (1, −1), = −t².
            binary = bool(before) and (before[-1].isalnum() or before[-1] in ")]‖|" or before[-1] in "".join(SUP.values()) + "".join(SUB.values()))
            out = before + (" − " if binary else ("" if not before or before[-1] in OPEN else " ") + "−")
        elif part == ",":
            out = before + ", "
        elif part == ":":
            out = before + ": "
        elif part == " ":
            out = out if out.endswith(" ") or not out else out + " "
        else:
            out += part
    out = re.sub(r" +", " ", out).strip()
    out = re.sub(r" ([.,;])$", r"\1", out)
    return out.replace("   ", "  ").replace("   ", "  ")
