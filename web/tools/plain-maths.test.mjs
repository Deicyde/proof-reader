import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { test } from "node:test";
import { plainMaths } from "../src/paper/plainMaths.ts";

const cases = {
  "U(x_0,x_1)=x_0^2+x_0x_1+x_1^2": "U(x₀, x₁) = x₀² + x₀x₁ + x₁²",
  "D^2f(a)(y,y)\\ge C\\lVert y\\rVert^2": "D²f(a)(y, y) ≥ C‖y‖²",
  "U(h)\\le\\tfrac32\\lVert h\\rVert^2": "U(h) ≤ (3/2)‖h‖²",
  "2\\left(y_0+\\tfrac c2y_1\\right)^2+2\\left(1-\\tfrac{c^2}4\\right)y_1^2": "2(y₀ + (c/2)y₁)² + 2(1 − c²/4)y₁²",
  "\\begin{pmatrix}2&1\\\\1&2\\end{pmatrix}": "[[2, 1], [1, 2]]",
  "W(-2,0)=4-8=-4<W(0)": "W(−2, 0) = 4 − 8 = −4 < W(0)",
  "t\\to-\\infty": "t → −∞",
  "\\lvert c\\rvert<2": "|c| < 2",
  "\\tfrac94": "9/4",
};

test("formulas read as Physlib writes them", () => {
  for (const [tex, text] of Object.entries(cases)) assert.equal(plainMaths(tex), text);
});

test("the site copies every coupled-spring formula as the GitHub edition writes it", () => {
  const paper = new URL("../../papers/coupled-spring/paper.md", import.meta.url).pathname;
  const tools = new URL("../../tools", import.meta.url).pathname;
  const script = `
import json, re, sys
sys.path.insert(0, ${JSON.stringify(tools)})
import markdown_edition as m, plain_maths as p
text = open(${JSON.stringify(paper)}, encoding="utf-8").read()
print(json.dumps([[a or b, p.convert(a or b)] for a, b in m.MATHS.findall(text)]))`;
  const pairs = JSON.parse(execFileSync("python3", ["-c", script], { encoding: "utf8" }));
  assert.ok(pairs.length > 30);
  for (const [tex, text] of pairs) assert.equal(plainMaths(tex), text, tex);
});
