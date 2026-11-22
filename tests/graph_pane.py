"""Drive the Graph view on every paper that has one and apply the shared checks of
docs/graph-pane.md (tests/graph_pane_checks.py): following the paper, after a click on a
marked passage, after a click on a card, and on the largest neighbourhoods, each time
opening the largest group and folding it with Fit.

    python3 tests/graph_pane.py                 # builds nothing; serves web/dist itself
    python3 tests/graph_pane.py --url http://127.0.0.1:8631/proof-reader/ --shots /tmp/shots
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from playwright.sync_api import Page, sync_playwright

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tests"))
from graph_pane_checks import check_graph_pane, check_groups  # noqa: E402
from journey import serve  # noqa: E402

DOCK = ".proof__lean"
SIZES = ((1440, 900), (2560, 1440))


def graph_papers() -> list[str]:
    index = json.loads((ROOT / "web" / "public" / "papers" / "index.json").read_text())
    moved = json.loads((ROOT / "web" / "library-redirects.json").read_text())["pages"]
    out = []
    for paper in index["papers"]:
        if paper["slug"] in moved:
            continue
        edition = json.loads((ROOT / "web" / "public" / "papers" / paper["slug"] / "edition.json").read_text())
        if edition["paper"].get("graph", True) is not False:
            out.append(paper["slug"])
    return out


def most_used(slug: str) -> str:
    edition = json.loads((ROOT / "web" / "public" / "papers" / slug / "edition.json").read_text())
    return max(edition["declarations"], key=lambda d: len(d["used_by"]))["id"]


def settle(page: Page) -> None:
    page.wait_for_timeout(700)


def open_paper(page: Page, url: str, slug: str, record: str = "") -> None:
    page.goto(f"{url}#/{slug}{'/' + record if record else ''}", wait_until="load")
    page.locator(".sheet__text").wait_for()
    page.locator(".fg").wait_for()
    if page.locator(".mode-toggle button[aria-pressed='true']", has_text="Lean").count():
        page.locator(".mode-toggle button", has_text="Graph").click()
    settle(page)


def click_passage(page: Page, nth: int) -> None:
    """Bring a marked passage to the reading line, as a reader would, and click it."""
    q = page.locator(".sheet__text .q[data-p]").nth(nth)
    q.evaluate("""(el) => { const pane = document.querySelector('[data-paper-pane]');
      pane.scrollTop += el.getBoundingClientRect().top - pane.getBoundingClientRect().top - pane.clientHeight * 0.35; }""")
    page.wait_for_timeout(500)
    box = q.bounding_box()
    page.mouse.click(box["x"] + min(30, box["width"] / 2), box["y"] + min(8, box["height"] / 2))
    settle(page)


def view_is_graph(page: Page) -> bool:
    return page.locator(".mode-toggle button[aria-pressed='true']", has_text="Graph").count() == 1


def run(page: Page, url: str, slug: str, size: tuple[int, int], shots: Path | None) -> list[str]:
    w, _ = size
    bad: list[str] = []
    label = f"{slug} {w}"
    open_paper(page, url, slug)
    # Following: the reading line in the middle of the paper.
    page.evaluate("""() => { const el = document.querySelector('[data-paper-pane]'); const qs = [...el.querySelectorAll('.q[data-p]')];
      const q = qs[Math.floor(qs.length / 2)]; el.scrollTop += q.getBoundingClientRect().top - el.getBoundingClientRect().top - el.clientHeight * 0.3; }""")
    page.wait_for_timeout(1200)
    bad += check_graph_pane(page, f"{label} following", dock=DOCK)
    bad += check_groups(page, f"{label} following")
    # A marked passage clicked: the view stays on Graph.
    click_passage(page, 3)
    if not view_is_graph(page):
        bad.append(f"{label}: a passage click changed the view")
    bad += check_graph_pane(page, f"{label} passage clicked", dock=DOCK)
    bad += check_groups(page, f"{label} passage clicked")
    # A card clicked: it becomes the subject.
    card = page.locator(".fg__card:not(.is-subject)").first
    if card.count():
        want = card.get_attribute("data-card")
        card.scroll_into_view_if_needed()
        card.click()
        settle(page)
        if not view_is_graph(page):
            bad.append(f"{label}: a card click changed the view")
        if page.locator(f".fg__card.is-subject[data-card='{want}']").count() == 0:
            bad.append(f"{label}: the clicked card {want} did not become the subject")
        bad += check_graph_pane(page, f"{label} card clicked", dock=DOCK)
        bad += check_groups(page, f"{label} card clicked")
    # The largest neighbourhood on this paper.
    big = most_used(slug)
    open_paper(page, url, slug, big)
    bad += check_graph_pane(page, f"{label} most used ({big})", dock=DOCK)
    bad += check_groups(page, f"{label} most used ({big})")
    if shots:
        page.screenshot(path=str(shots / f"{slug}-big-{w}.png"))
    return bad


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--url", help="a running site, ending in /")
    parser.add_argument("--dist", type=Path, default=ROOT / "web" / "dist")
    parser.add_argument("--shots", type=Path)
    args = parser.parse_args()
    server = None
    url = args.url
    if not url:
        url, server = serve(args.dist)
    if args.shots:
        args.shots.mkdir(parents=True, exist_ok=True)
    bad: list[str] = []
    errors: list[str] = []
    try:
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            for size in SIZES:
                page = browser.new_page(viewport={"width": size[0], "height": size[1]})
                page.on("console", lambda m: m.type == "error" and errors.append(m.text))
                page.on("pageerror", lambda e: errors.append(str(e)))
                for slug in graph_papers():
                    bad += run(page, url, slug, size, args.shots)
                page.close()
            browser.close()
    finally:
        if server:
            server.terminate()
    bad += [f"console: {e}" for e in errors]
    for line in bad:
        print("FAIL", line)
    print(f"{len(bad)} failures")
    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main())
