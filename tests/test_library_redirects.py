"""Exercise the generated browser redirect for both hash and static bookmarks."""
import json
import shutil
import subprocess
import unittest
from pathlib import Path

WEB = Path(__file__).resolve().parents[1] / "web"
STUB = WEB / "public/library-redirects.js"
TABLE = WEB / "library-redirects.json"
LIBRARY = "https://wcook04.github.io/library/"
RUN = """
const src = require("node:fs").readFileSync(process.argv[1], "utf8");
const input = JSON.parse(process.argv[2]);
const doc = { documentElement: { style: {} } };
const calls = [];
let onHash;
const win = { addEventListener(event, handler) {
  if (event === "hashchange") onHash = handler;
} };
const loc = { hash: input.hash, pathname: input.pathname, replace(url) { calls.push(url); } };
new Function("window", "location", "document", src)(win, loc, doc);
if (input.nextHash !== null) {
  loc.hash = input.nextHash;
  onHash();
}
console.log(JSON.stringify({ calls, hidden: doc.documentElement.style.visibility === "hidden" }));
"""


@unittest.skipUnless(shutil.which("node"), "needs node")
class LibraryRedirects(unittest.TestCase):
    def redirects(self, hash="", pathname="/proof-reader/", next_hash=None):
        state = json.dumps({"hash": hash, "pathname": pathname, "nextHash": next_hash})
        result = subprocess.run(["node", "-e", RUN, str(STUB), state], capture_output=True, text=True, check=True)
        return json.loads(result.stdout)

    def assertRedirect(self, destination, **input):
        self.assertEqual(self.redirects(**input), {"calls": [f"{LIBRARY}{destination}"], "hidden": True})

    def test_original_paper_bookmarks(self):
        for hash, destination in [
            ("#/euler/result-1.1", "euler/theorem-1.1/"),
            ("#/euler/@page-5", "euler/?view=pdf&page=5"),
            ("#/euler/TorusEuler.theorem11", "euler/lean/TorusEuler.theorem11"),
            ("#/euler/@declarations", "euler/lean?list=papers"),
            ("#/navier-stokes-paper/@claim-theorem-1-1", "navier-stokes/theorem-1.1/"),
        ]:
            with self.subTest(hash=hash):
                self.assertRedirect(destination, hash=hash)
        self.assertRedirect("euler/#1", pathname="/proof-reader/euler/", hash="#1-introduction")

    def test_retired_pages_and_hash_changes_open_the_original(self):
        self.assertRedirect("navier-stokes/", pathname="/proof-reader/navier-stokes-library-07/", hash="#old-heading")
        self.assertRedirect("navier-stokes/", next_hash="#/navier-stokes-digest/@old-quote")
        self.assertRedirect("navier-stokes/", hash="#/navier-stokes-part-1/@page-99")

    def test_ordinary_standalone_routes_do_not_redirect(self):
        for hash in ["#/", "#/contextual-embeddings", "#/pcp-specialist", "#/constructor", "#/navier-stokes-library-31"]:
            with self.subTest(hash=hash):
                self.assertEqual(self.redirects(hash=hash), {"calls": [], "hidden": False})

    def test_verified_pcp_bookmarks_open_the_matching_account(self):
        for slug, destination in [
            ("pcp-full-argument", "pcp/full-argument/"),
            ("pcp-exposition", "pcp/exposition/"),
            ("pcp-reading-guide", "pcp/reading-guide/"),
        ]:
            with self.subTest(slug=slug):
                self.assertRedirect(destination, hash=f"#/{slug}")
                self.assertRedirect(destination, pathname=f"/proof-reader/{slug}/")
        self.assertRedirect("pcp/full-argument/#2.3", hash="#/pcp-full-argument/@s-2.3")
        self.assertRedirect("pcp/exposition/?n=pcp.theorem-1.1&l=b1596-1763&v=lean",
                            hash="#/pcp-exposition/@pcp-expository-opening")
        self.assertRedirect("pcp/reading-guide/#4", pathname="/proof-reader/pcp-reading-guide/", hash="#4-the-pcp-theorem")

    def test_pcp_addresses_without_a_verified_target_stay_in_proof_reader(self):
        for record in ("@sheet", "@file", "@declarations", "unknown", "@pcp-expository-opening/extra"):
            with self.subTest(record=record):
                self.assertEqual(self.redirects(hash=f"#/pcp-exposition/{record}"), {"calls": [], "hidden": False})
        self.assertEqual(
            self.redirects(pathname="/proof-reader/pcp-exposition/", hash="#sheet"),
            {"calls": ["/proof-reader/#/pcp-exposition#sheet"], "hidden": False},
        )
        self.assertEqual(
            self.redirects(hash="#/pcp-exposition/@sheet", next_hash="#/pcp-exposition/@pcp-expository-opening"),
            {"calls": [], "hidden": False},
        )

    def test_all_retired_rows_match_the_bookmark_mapper(self):
        pages = json.loads(TABLE.read_text())["pages"]
        wire = json.loads(STUB.read_text().split("var T = ", 1)[1].split(";\n", 1)[0])
        self.assertEqual(pages, wire)
        retired = {slug for slug, entry in pages.items() if entry.get("retired")}
        self.assertTrue({f"navier-stokes-library-{i:02d}" for i in range(1, 31)} <= retired)
        self.assertEqual({slug for slug in pages if slug not in retired and "bookmarks" not in pages[slug]},
                         {"euler", "navier-stokes-paper"})


if __name__ == "__main__":
    unittest.main()
