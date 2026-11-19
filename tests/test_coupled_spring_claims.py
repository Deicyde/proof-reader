"""Regression checks for selected formulas and statements in the coupled-spring page.

These checks pair exact calculations with expected Markdown fragments. They catch
changes to those fragments and leave other prose and modelling choices to review.

The full rational grid determines the two-variable polynomials checked on it.
Calculations using subsets of the grid are regression samples.
"""
from __future__ import annotations

import unittest
from fractions import Fraction as F
from pathlib import Path

PAPER = (Path(__file__).resolve().parent.parent / "papers" / "coupled-spring" / "paper.md").read_text(encoding="utf-8")
GRID = [(F(a, 2), F(b, 3)) for a in range(-2, 3) for b in range(-2, 3)]
K = ((2, 1), (1, 2))


def U(x0, x1):
    return x0 * x0 + x0 * x1 + x1 * x1


def W(x0, x1):
    return U(x0, x1) + x0 ** 3


def Kv(v):
    return tuple(sum(K[i][j] * v[j] for j in range(2)) for i in range(2))


class CoupledSpringClaims(unittest.TestCase):
    def states(self, *fragments: str) -> None:
        for fragment in fragments:
            self.assertIn(fragment, PAPER, "the page no longer states this")

    def test_the_three_forms_are_one_function(self) -> None:
        for x0, x1 in GRID:
            self.assertEqual(U(x0, x1), F(1, 2) * (x0 ** 2 + x1 ** 2 + (x0 + x1) ** 2))
            self.assertEqual(U(x0, x1), (x0 + x1 / 2) ** 2 + F(3, 4) * x1 ** 2)
        self.states(r"U(h)=\tfrac12\left(h_0^2+h_1^2+(h_0+h_1)^2\right)",
                    r"U(x)=\left(x_0+\tfrac12x_1\right)^2+\tfrac34x_1^2")

    def test_the_global_minimum_is_claimed_only_away_from_the_origin(self) -> None:
        self.assertEqual(U(0, 0), 0)
        for x0, x1 in GRID:
            if (x0, x1) != (0, 0):
                self.assertGreater(U(x0, x1), 0)
        self.states(r"For every nonzero $x\in\mathbb R^2$, $U(x)>U(0)$.", "Both sides are zero at $x=0$.")

    def test_the_physlib_theorem_is_called_local(self) -> None:
        self.states("**PhyslibAlpha theorem.** The coupled spring potential $U$ has a local minimum")
        self.assertNotIn("**PhyslibAlpha theorem.** The coupled spring potential $U$ has a global", PAPER)

    def test_derivative_and_remainder(self) -> None:
        for (x0, x1) in GRID:
            for (h0, h1) in GRID[::7]:
                linear = (2 * x0 + x1) * h0 + (x0 + 2 * x1) * h1
                self.assertEqual(U(x0 + h0, x1 + h1) - U(x0, x1) - linear, U(h0, h1))
        for h0, h1 in GRID:
            # 3/2|h|^2 - U(h) = (h0 - h1)^2 / 2 >= 0, and U(h) >= 0.
            self.assertEqual(F(3, 2) * (h0 ** 2 + h1 ** 2) - U(h0, h1), (h0 - h1) ** 2 / 2)
        self.states(r"$$DU(x)[h]=(2x_0+x_1)h_0+(x_0+2x_1)h_1.$$", r"$0\le U(h)\le\tfrac32\lVert h\rVert^2$")

    def test_hessian_bound_and_where_it_is_sharp(self) -> None:
        for h0, h1 in GRID:
            q = sum(h[i] * Kv(h)[i] for h in [(h0, h1)] for i in range(2))
            self.assertEqual(q, 2 * U(h0, h1))
            self.assertEqual(q - (h0 ** 2 + h1 ** 2), (h0 + h1) ** 2)
        self.states(r"$$K=\begin{pmatrix}2&1\\1&2\end{pmatrix}.$$", r"$h^{T}Kh\ge\lVert h\rVert^2$",
                    "The last square\nvanishes when $h_0=-h_1$")

    def test_normal_modes_and_their_frequencies(self) -> None:
        # The frequency written on the page is sqrt(lambda k / m) for the eigenvalue lambda of K.
        written = {}
        for name, v in (("-", (1, -1)), ("+", (1, 1))):
            image = Kv(v)
            lam = F(image[0], v[0])
            self.assertEqual(image, tuple(lam * c for c in v))
            written[name] = r"\sqrt{k/m}" if lam == 1 else rf"\sqrt{{{lam}k/m}}"
        self.states(rf"$\omega_-={written['-']}$", rf"$\omega_+={written['+']}$")

    def test_the_release_from_one_displaced_mass(self) -> None:
        # (d, 0) = d/2 (1, -1) + d/2 (1, 1), so x1(t) = d/2 (cos w+ t - cos w- t).
        d = F(1)
        self.assertEqual((d / 2 + d / 2, -d / 2 + d / 2), (d, 0))
        self.states(r"$(d,0)=\tfrac d2(1,-1)+\tfrac d2(1,1)$",
                    r"x_1(t)=\tfrac d2\left(\cos(\omega_+t)-\cos(\omega_-t)\right)")

    def test_the_force_on_the_right_mass(self) -> None:
        # Force in the right mass's own positive direction is -k times dU/dx1 = -k (x0 + 2 x1).
        d = F(1)
        self.assertEqual(-(d + 2 * 0), -d)
        self.states("giving force $-kd$\nin its own positive direction")

    def test_the_cubic_keeps_the_local_minimum_and_loses_the_global_one(self) -> None:
        for x0, x1 in GRID:
            bound = (x1 + x0 / 2) ** 2 + x0 ** 2 / 2
            self.assertEqual(W(x0, x1) - bound, x0 ** 2 * (x0 + F(1, 4)))
        self.assertEqual(W(-2, 0), -4)
        self.states(r"$|x_0|<\tfrac14$, then", r"$W(x)\ge\left(x_1+\tfrac12x_0\right)^2+\tfrac12x_0^2$",
                    r"$W(-2,0)=-4<W(0)$")


if __name__ == "__main__":
    unittest.main()
