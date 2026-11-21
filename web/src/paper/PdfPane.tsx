// The authors' PDF, drawn by pdf.js. Passages are boxes computed from the PDF's
// own words at build time, so the page never retypes the paper. The highlight
// lies under the ink, as a highlighter does, and a bar in the margin marks each
// sentence tied to the Lean. Blank margins are trimmed on screen, so the type
// is as large as the page allows. Scrolling reports the passage at the reading
// line. It stays paper-coloured at night: it is the authors' page.

import { selecting } from "./clickIntent";
import { forwardRef, useCallback, useEffect, useImperativeHandle, useLayoutEffect, useMemo, useRef, useState, type ReactNode } from "react";
import * as pdfjs from "pdfjs-dist";
import workerUrl from "pdfjs-dist/build/pdf.worker.min.mjs?url";
import type { PDFDocumentProxy } from "pdfjs-dist";
import type { Mention, Passage } from "../app/edition";
import type { Pin } from "../app/history";
import { DWELL_MS, FOLLOW_MS, READING_LINE, type Follow, type PaperHandle, type Pointed, type Target, type Where, type Zone } from "./reading-line";

pdfjs.GlobalWorkerOptions.workerSrc = workerUrl;

/** The space above each page; app.css sets the same 20px. */
const PAGE_GAP = 20;
/** Room at the right for the ruler that shows where in the whole document the links are. */
const RULER_SPACE = 22;
/** Zoom steps, as a share of the width that fits the pane. */
const ZOOMS = [0.5, 0.67, 0.8, 1, 1.25, 1.5, 2, 2.5, 3];

interface Props {
  url: string;
  /** Each page's width and height, in PDF points. */
  sizes: [number, number][];
  /** The box on every page that holds something printed. */
  crop: [number, number, number, number];
  passages: Passage[];
  /** Every printed occurrence of a Lean name. */
  mentions: Mention[];
  hidden: boolean;
  pin: Pin | null;
  lit: ReadonlySet<string>;
  onFollow: Follow;
  onSettle(): void;
  onPin(id: string): void;
  onName(name: string): void;
  onPoint(pointed: Pointed): void;
  onReady(): void;
  /** Below the last page: whose words these are, and the family's other sites. */
  foot?: ReactNode;
}

export const PdfPane = forwardRef<PaperHandle, Props>(function PdfPane(props, ref) {
  const { url, sizes, crop, passages, mentions, hidden, pin, lit } = props;
  const latest = useRef(props);
  latest.current = props;
  const scroller = useRef<HTMLDivElement>(null);
  const [pdf, setPdf] = useState<PDFDocumentProxy | null>(null);
  const [failed, setFailed] = useState(false);
  const [fit, setFit] = useState(0);
  const [zoom, setZoom] = useState(1);
  const width = Math.round(fit * zoom);
  const anchor = useRef<number | null>(null);
  const [view, setView] = useState<[number, number]>([0, 0]);
  const [hover, setHover] = useState<string | null>(null);
  const [hoverName, setHoverName] = useState<string | null>(null);
  // The statement under the line, drawn at once; the right page hears after a hold.
  const [active, setActive] = useState<string | null>(null);
  const lock = useRef(0);
  const goal = useRef<number | null>(null);
  const arrive = useRef(0);
  const follow = useRef(0);
  const settle = useRef(0);
  const dwell = useRef(0);
  const lastScroll = useRef(0);
  const lastTarget = useRef<Target | null>(null);
  const line = useRef<string | null>(null);
  const zone = useRef<Zone>("before");
  const lineAbove = useRef<string | null>(null);

  const [left, top, right, bottom] = crop;
  const scale = width / (right - left);
  const pageHeight = (bottom - top) * scale;

  useEffect(() => {
    let live = true;
    let task: ReturnType<typeof pdfjs.getDocument> | null = null;
    fetch(url)
      .then((response) => {
        if (!response.ok) throw new Error(String(response.status));
        return response.arrayBuffer();
      })
      .then((data) => {
        if (!live) return;
        task = pdfjs.getDocument({ data });
        return task.promise.then((doc) => {
          if (live) setPdf(doc);
        });
      })
      .catch(() => live && setFailed(true));
    return () => {
      live = false;
      void task?.destroy();
    };
  }, [url]);

  // Measured before the first paint, so the pages never jump into place.
  useLayoutEffect(() => {
    const el = scroller.current;
    if (!el) return;
    const measure = () => {
      if (el.clientWidth) setFit(el.clientWidth - PAGE_GAP - RULER_SPACE);
    };
    measure();
    const observer = new ResizeObserver(measure);
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const byPage = useMemo(() => {
    const map = new Map<number, Passage[]>();
    for (const p of passages) if (p.page !== null) map.set(p.page, [...(map.get(p.page) ?? []), p]);
    return map;
  }, [passages]);

  const namesByPage = useMemo(() => {
    const map = new Map<number, Mention[]>();
    for (const m of mentions) map.set(m.page, [...(map.get(m.page) ?? []), m]);
    return map;
  }, [mentions]);

  const passageTop = useCallback(
    // From the page sizes, not the DOM, so it holds while the layout settles.
    (p: Passage) => p.page === null ? Infinity : PAGE_GAP + (p.page - 1) * (pageHeight + PAGE_GAP) + (p.rects[0][1] - top) * scale,
    [pageHeight, scale, top],
  );

  const whereNow = useCallback((): Where => {
    const el = scroller.current;
    if (!el) return { passage: null, zone: "before", above: null, section: null, page: 1, into: 0 };
    const at = el.scrollTop + el.clientHeight * READING_LINE;
    let best: Passage | null = null;
    let bestGap = el.clientHeight * 0.5;
    let first = Infinity;
    let last = -Infinity;
    let above: string | null = null;
    let aboveTop = -Infinity;
    for (const p of passages) {
      const y = passageTop(p);
      first = Math.min(first, y);
      last = Math.max(last, y);
      if (y <= at && y >= aboveTop) {
        above = p.id;
        aboveTop = y;
      }
      const gap = Math.abs(y - at);
      if (gap <= bestGap) {
        best = p;
        bestGap = gap;
      }
    }
    const step = Math.max(1, pageHeight + PAGE_GAP);
    const page = Math.min(sizes.length, Math.floor(Math.max(0, at - PAGE_GAP) / step) + 1);
    return {
      passage: best?.id ?? null,
      zone: best ? "tied" : at < first ? "before" : at > last ? "after" : "between",
      above,
      section: null,
      page,
      into: (Math.max(0, at - PAGE_GAP) / step) % 1,
    };
  }, [pageHeight, passageTop, passages, sizes.length]);

  const followSoon = useCallback((id: string | null, kind: Zone, above: string | null) => {
    window.clearTimeout(follow.current);
    follow.current = window.setTimeout(() => latest.current.onFollow(id, kind, above), FOLLOW_MS);
  }, []);

  const read = useCallback(() => {
    const here = whereNow();
    if (here.passage !== line.current || here.zone !== zone.current || here.above !== lineAbove.current) {
      line.current = here.passage;
      zone.current = here.zone;
      lineAbove.current = here.above;
      setActive(here.passage);
      followSoon(here.passage, here.zone, here.above);
    }
  }, [followSoon, whereNow]);

  const scrollTo = useCallback((to: number, instant: boolean, thenRead: boolean) => {
    const el = scroller.current;
    if (!el) return;
    const end = Math.max(0, Math.min(to, el.scrollHeight - el.clientHeight));
    goal.current = end;
    window.clearTimeout(arrive.current);
    if (instant || window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      el.scrollTop = end;
      lock.current = Date.now() + 60;
      if (thenRead) {
        goal.current = null;
        read();
      }
      return;
    }
    lock.current = Date.now() + 1500;
    el.scrollTo({ top: end, behavior: "smooth" });
    // A background tab may never run the animation, so arrive regardless.
    arrive.current = window.setTimeout(() => {
      if (Math.abs(el.scrollTop - end) > 2) el.scrollTop = end;
      lock.current = 0;
      if (thenRead) {
        goal.current = null;
        read();
      }
    }, 950);
  }, [read]);

  const place = useCallback((target: Target, instant = false): boolean => {
    const el = scroller.current;
    if (!el || !width) {
      lastTarget.current = target;
      return !!el;
    }
    lastTarget.current = target;
    if ("start" in target) {
      scrollTo(0, instant, true);
      return true;
    }
    if ("top" in target) {
      if (target.fallback && Math.abs(target.width - el.clientWidth) > 1) return place(target.fallback, instant);
      scrollTo(target.top, true, true);
      // A return is not reading on: the right page comes back at once.
      window.clearTimeout(follow.current);
      latest.current.onFollow(line.current, zone.current, lineAbove.current);
      return true;
    }
    if ("passage" in target) {
      const passage = passages.find((p) => p.id === target.passage);
      if (!passage) return false;
      line.current = passage.id;
      zone.current = "tied";
      setActive(passage.id);
      lineAbove.current = passage.id;
      scrollTo(passageTop(passage) - el.clientHeight * READING_LINE, instant, false);
      followSoon(passage.id, "tied", passage.id);
      return true;
    }
    if ("page" in target) {
      const offset = (target.into ?? 0) * (pageHeight + PAGE_GAP);
      const y = PAGE_GAP + (target.page - 1) * (pageHeight + PAGE_GAP) + offset;
      scrollTo(target.into === undefined ? y - 8 : y - el.clientHeight * READING_LINE, instant, true);
      return true;
    }
    return false;
  }, [followSoon, pageHeight, passageTop, passages, scrollTo, width]);

  /** Zoom about the reading line: the same place in the document stays under it. */
  const zoomTo = useCallback((next: number) => {
    const el = scroller.current;
    if (!el || !pageHeight) return;
    anchor.current = (el.scrollTop + el.clientHeight * READING_LINE - PAGE_GAP) / (pageHeight + PAGE_GAP);
    setZoom(Math.min(ZOOMS[ZOOMS.length - 1], Math.max(ZOOMS[0], next)));
  }, [pageHeight]);
  const zoomStep = useCallback((dir: 1 | -1) => {
    const i = ZOOMS.findIndex((z) => z >= zoom - 1e-6);
    zoomTo(ZOOMS[Math.min(ZOOMS.length - 1, Math.max(0, (dir > 0 ? (ZOOMS[i] > zoom + 1e-6 ? i : i + 1) : i - 1)))]);
  }, [zoom, zoomTo]);

  useLayoutEffect(() => {
    const el = scroller.current;
    if (!el || anchor.current === null) return;
    el.scrollTop = PAGE_GAP + anchor.current * (pageHeight + PAGE_GAP) - el.clientHeight * READING_LINE;
    el.scrollLeft = (el.scrollWidth - el.clientWidth) / 2;
    anchor.current = null;
  }, [pageHeight]);

  // A trackpad pinch arrives as a wheel event with Ctrl held, as does Ctrl or Cmd with a wheel.
  useEffect(() => {
    const el = scroller.current;
    if (!el) return;
    const onWheel = (e: WheelEvent) => {
      if (!e.ctrlKey && !e.metaKey) return;
      e.preventDefault();
      zoomTo(zoom * Math.exp(-e.deltaY / 300));
    };
    el.addEventListener("wheel", onWheel, { passive: false });
    return () => el.removeEventListener("wheel", onWheel);
  }, [zoom, zoomTo]);

  // Which stretch of the document is on screen, for the ruler.
  useEffect(() => {
    const el = scroller.current;
    if (!el) return;
    // Straight from the scroll event: a frame callback may never run in a background tab.
    const update = () => setView([el.scrollTop, el.clientHeight]);
    update();
    el.addEventListener("scroll", update, { passive: true });
    return () => el.removeEventListener("scroll", update);
  }, [width]);

  const pagesHeight = PAGE_GAP + sizes.length * (pageHeight + PAGE_GAP);
  const marks = useMemo(() => passages.filter((p) => p.page !== null).map((p) => ({
    id: p.id,
    at: passageTop(p) / Math.max(1, pagesHeight),
    span: Math.max(0, (p.rects[p.rects.length - 1][3] - p.rects[0][1]) * scale) / Math.max(1, pagesHeight),
    kind: rulerKind(p),
    label: `Page ${p.page}${p.title ? `, ${p.title}` : ""}: ${RULER_WORDS[rulerKind(p)]}`,
  })), [passages, passageTop, pagesHeight, scale]);

  useImperativeHandle(ref, (): PaperHandle => ({
    place,
    top: () => scroller.current?.scrollTop ?? 0,
    width: () => scroller.current?.clientWidth ?? 0,
    where: whereNow,
    active: () => line.current,
    block: () => null,
    focusPassage: () => scroller.current?.focus({ preventScroll: true }),
    mark: (id) => {
      line.current = id;
      setActive(id);
    },
    insets: () => [],
    setInsets: () => undefined,
    closeInsets: () => false,
  }), [place, whereNow]);

  // A new width rescales every page, so go back to what was asked for.
  useEffect(() => {
    if (!width) return;
    latest.current.onReady();
    if (lastTarget.current) place(lastTarget.current, true);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [width]);

  useEffect(() => {
    const el = scroller.current;
    if (!el || !width) return;
    let frame = 0;
    const tick = () => {
      frame = 0;
      if (Date.now() < lock.current) return;
      if (goal.current !== null) {
        if (Math.abs(el.scrollTop - goal.current) <= 2) return;
        goal.current = null;
      }
      read();
    };
    const onScroll = () => {
      lastScroll.current = Date.now();
      if (!frame) frame = requestAnimationFrame(tick);
      window.clearTimeout(settle.current);
      settle.current = window.setTimeout(() => latest.current.onSettle(), 220);
    };
    el.addEventListener("scroll", onScroll, { passive: true });
    return () => {
      el.removeEventListener("scroll", onScroll);
      if (frame) cancelAnimationFrame(frame);
      window.clearTimeout(settle.current);
    };
  }, [passages, passageTop, read, width]);

  useEffect(() => () => {
    window.clearTimeout(arrive.current);
    window.clearTimeout(dwell.current);
  }, []);

  const userInput = () => {
    lock.current = 0;
    goal.current = null;
    lastTarget.current = null;
    window.clearTimeout(arrive.current);
  };

  const pointSoon = (pointed: Pointed) => {
    window.clearTimeout(dwell.current);
    if (!pointed) {
      latest.current.onPoint(null);
      return;
    }
    if (Date.now() - lastScroll.current < 180) return;
    dwell.current = window.setTimeout(() => latest.current.onPoint(pointed), DWELL_MS);
  };

  /** A pointer position in PDF points. */
  const point = (event: React.MouseEvent<HTMLDivElement>) => {
    const box = event.currentTarget.getBoundingClientRect();
    return { x: (event.clientX - box.left) / scale + left, y: (event.clientY - box.top) / scale + top };
  };

  const nameAt = (event: React.MouseEvent<HTMLDivElement>, page: number): Mention | null => {
    const { x, y } = point(event);
    return (namesByPage.get(page) ?? []).find(({ rect: [x0, y0, x1, y1] }) => x >= x0 && x <= x1 && y >= y0 && y <= y1) ?? null;
  };

  const hit = (event: React.MouseEvent<HTMLDivElement>, page: number): string | null => {
    const { x, y } = point(event);
    for (const p of byPage.get(page) ?? []) {
      if (p.rects.some(([x0, y0, x1, y1]) => x >= x0 - 2 && x <= x1 + 2 && y >= y0 - 1 && y <= y1 + 1)) return p.id;
    }
    return null;
  };

  return (
    <>
    {!hidden && width > 0 && (
      <div className="pdfzoom" role="group" aria-label="Zoom the PDF">
        <button type="button" onClick={() => zoomStep(-1)} disabled={zoom <= ZOOMS[0] + 1e-6} aria-label="Zoom out">−</button>
        <button type="button" className="pdfzoom__fit" onClick={() => zoomTo(1)} aria-label="Fit the page to the pane" title="Fit the page to the pane">{Math.round(zoom * 100)}%</button>
        <button type="button" onClick={() => zoomStep(1)} disabled={zoom >= ZOOMS[ZOOMS.length - 1] - 1e-6} aria-label="Zoom in">+</button>
      </div>
    )}
    {!hidden && width > 0 && marks.length > 0 && (
      <div
        className="ruler"
        aria-label="Where the linked passages are in the whole document"
        title="Each mark is a linked passage; click one to open it, or anywhere to go there"
        onClick={(e) => {
          const el = scroller.current;
          if (!el) return;
          const box = e.currentTarget.getBoundingClientRect();
          const at = (e.clientY - box.top) / box.height;
          const near = marks.reduce<{ id: string; gap: number } | null>((best, m) => {
            const gap = Math.abs((m.at - at) * box.height);
            return gap < 5 && (!best || gap < best.gap) ? { id: m.id, gap } : best;
          }, null);
          if (near) {
            // Go to the passage, then open it, as clicking it on the page would.
            const target = marks.find((m) => m.id === near.id);
            userInput();
            if (target) scrollTo(target.at * pagesHeight - el.clientHeight * READING_LINE, false, false);
            latest.current.onPin(near.id);
          } else {
            userInput();
            scrollTo(at * pagesHeight - el.clientHeight * READING_LINE, false, true);
          }
        }}
      >
        <span className="ruler__view" style={{ top: `${(view[0] / Math.max(1, pagesHeight)) * 100}%`, height: `${Math.max(1, (view[1] / Math.max(1, pagesHeight)) * 100)}%` }} />
        {marks.map((m) => (
          <span
            key={m.id}
            className={`ruler__mark ruler__mark--${m.kind}${m.id === pin?.passage || m.id === active ? " is-active" : ""}`}
            style={{ top: `${m.at * 100}%`, height: `max(3px, ${m.span * 100}%)` }}
            title={m.label}
          />
        ))}
      </div>
    )}
    <div
      className={`pdf${marks.length ? " pdf--ruled" : ""}${zoom > 1 ? " pdf--wide" : ""}`}
      data-paper-pane={hidden ? undefined : ""}
      hidden={hidden}
      ref={scroller}
      tabIndex={0}
      aria-label="The paper"
      onWheel={userInput}
      onTouchMove={userInput}
      onKeyDown={(e) => {
        if (["ArrowDown", "ArrowUp", "PageDown", "PageUp", " ", "Home", "End"].includes(e.key)) userInput();
      }}
    >
      {failed && <p className="pdf__failed">The PDF could not be loaded. Use the link to the published paper above.</p>}
      {width > 0 && sizes.map(([w, h], index) => {
        const page = index + 1;
        return (
          <div
            key={page}
            className={`pdf__page${hover || hoverName ? " has-hover" : ""}`}
            data-page={page}
            style={{ width, height: pageHeight, ...(zoom < 1 ? { marginRight: "auto" } : {}) }}
            onMouseMove={(e) => {
              const name = nameAt(e, page);
              const key = name ? `${page}:${name.rect[0]}:${name.rect[1]}` : null;
              const id = name ? null : hit(e, page);
              if (key !== hoverName) {
                setHoverName(key);
                pointSoon(name ? { kind: "name", id: name.name } : null);
              }
              if (id !== hover) {
                setHover(id);
                if (!name) pointSoon(id ? { kind: "passage", id } : null);
              }
            }}
            onMouseLeave={() => {
              setHover(null);
              setHoverName(null);
              pointSoon(null);
            }}
            onClick={(e) => {
              if (selecting(e)) return;
              const name = nameAt(e, page);
              if (name) return latest.current.onName(name.name);
              const id = hit(e, page);
              if (id) latest.current.onPin(id);
            }}
          >
            <div className="pdf__whole" style={{ left: -left * scale, top: -top * scale, width: w * scale, height: h * scale }}>
              {(namesByPage.get(page) ?? []).map((m) => {
                const key = `${page}:${m.rect[0]}:${m.rect[1]}`;
                const [x0, y0, x1, y1] = m.rect;
                return <span key={key} className={`mention${hoverName === key ? " is-hover" : ""}`} style={{ left: x0 * scale, top: y0 * scale, width: (x1 - x0) * scale, height: (y1 - y0) * scale }} />;
              })}
              {(byPage.get(page) ?? []).flatMap((p) => {
                const state = `${p.id === active || p.id === pin?.passage ? " is-active" : ""}${p.id === hover ? " is-hover" : ""}${lit.has(p.id) ? " is-lit" : ""}`;
                const first = p.rects[0][1];
                const last = p.rects[p.rects.length - 1][3];
                return [
                  <span key={`${p.id}-tie`} data-passage={p.id} className={`tie${state}`} style={{ left: (right - 6) * scale, top: first * scale, height: (last - first) * scale }} />,
                  ...p.rects.map(([x0, y0, x1, y1], i) => (
                    <span
                      key={`${p.id}${i}`}
                      data-passage={p.id}
                      className={`mark${state}`}
                      style={{ left: (x0 - 1.5) * scale, top: (y0 - 0.5) * scale, width: (x1 - x0 + 3) * scale, height: (y1 - y0 + 1) * scale }}
                    />
                  )),
                ];
              })}
              {pdf && <PageCanvas pdf={pdf} page={page} width={w * scale} root={scroller} />}
            </div>
          </div>
        );
      })}
      {props.foot}
    </div>
    </>
  );
});

type RulerKind = "agree" | "found" | "missed" | "linked";
const RULER_WORDS: Record<RulerKind, string> = {
  agree: "found by the matcher, and the authors cite it",
  found: "found by the matcher; the authors cite it elsewhere or not at all",
  missed: "the authors cite it; the matcher did not find it",
  linked: "linked",
};
function rulerKind(p: Passage): RulerKind {
  const all = Object.values(p.match ?? {});
  if (!all.length) return "linked";
  if (all.some((m) => m.found_by.length && m.authors === "cites")) return "agree";
  if (all.some((m) => m.found_by.length)) return "found";
  return "missed";
}

function PageCanvas({ pdf, page, width, root }: { pdf: PDFDocumentProxy; page: number; width: number; root: React.RefObject<HTMLDivElement | null> }) {
  const holder = useRef<HTMLDivElement>(null);
  const canvas = useRef<HTMLCanvasElement>(null);
  const text = useRef<HTMLDivElement>(null);
  const [near, setNear] = useState(false);

  useEffect(() => {
    const el = holder.current;
    if (!el) return;
    // Near enough to read soon, or far enough to give the memory back: a long standard has
    // over a hundred pages, and every drawn page holds a canvas of two pixels to a point.
    const observer = new IntersectionObserver(([entry]) => setNear(entry.isIntersecting), { root: root.current, rootMargin: "1200px 0px" });
    observer.observe(el);
    return () => observer.disconnect();
  }, [root]);

  useEffect(() => {
    if (!near) {
      // Keep the page's place on screen, drop what it drew.
      if (canvas.current) {
        canvas.current.width = 0;
        canvas.current.height = 0;
      }
      text.current?.replaceChildren();
      return;
    }
    let cancelled = false;
    let renderTask: { cancel(): void; promise: Promise<void> } | null = null;
    void (async () => {
      const proxy = await pdf.getPage(page);
      if (cancelled || !canvas.current || !text.current) return;
      const unit = proxy.getViewport({ scale: 1 });
      const cssScale = width / unit.width;
      const dpr = Math.min(window.devicePixelRatio || 1, 2);
      // Never fewer than two pixels to a point: the paper is the page.
      const viewport = proxy.getViewport({ scale: Math.max(cssScale * dpr, 2) });
      const c = canvas.current;
      c.width = Math.floor(viewport.width);
      c.height = Math.floor(viewport.height);
      c.style.width = `${width}px`;
      c.style.height = `${unit.height * cssScale}px`;
      renderTask = proxy.render({ canvasContext: c.getContext("2d")!, viewport });
      await renderTask.promise.catch(() => undefined);
      if (cancelled || !text.current) return;
      const layer = text.current;
      layer.replaceChildren();
      layer.style.setProperty("--scale-factor", String(cssScale));
      await new pdfjs.TextLayer({
        textContentSource: await proxy.getTextContent(),
        container: layer,
        viewport: proxy.getViewport({ scale: cssScale }),
      }).render();
    })();
    return () => {
      cancelled = true;
      renderTask?.cancel();
    };
  }, [near, pdf, page, width]);

  return (
    <div className="pdf__sheet" ref={holder}>
      <canvas ref={canvas} aria-label={`Page ${page}`} />
      <div className="textLayer" ref={text} />
    </div>
  );
}
