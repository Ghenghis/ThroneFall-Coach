"""build_pdfs — render the reference documents to PDF (Markdown → HTML → headless Chromium) and merge a combined handbook.

  reference/pdf/<name>.pdf          one PDF per document
  reference/pdf/Thronefall-Reference-Handbook.pdf   cover + table of contents + every document, with bookmarks

Relative images are resolved against each document; links between .md files are rendered as plain text (PDFs are standalone).

usage: python build_pdfs.py [--only SUBSTRING] [--no-combined]
"""
from __future__ import annotations

import argparse
import datetime
import html
import os
import re
import sys
import urllib.parse

import markdown
from pygments.formatters import HtmlFormatter
from pypdf import PdfReader, PdfWriter

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
DOCS = os.path.join(REF, "docs")
OUT = os.path.join(REF, "pdf")
HTML_DIR = os.path.join(OUT, "_html")

# (title, relative path under reference/docs, landscape)
ORDER = [
    ("Index and how to use this pack", "00-README-INDEX.md", False),
    ("Reverse-engineering primer and glossary", "01-re-primer-glossary.md", False),
    ("Build fingerprint and drift (2.13 → 2.14)", "02-build-fingerprint-and-drift.md", True),
    ("Architecture and game loop", "03-architecture-and-game-loop.md", False),
    ("State map", "04-state-map.md", True),
    ("Action map", "05-action-map.md", True),
    ("Hook map", "06-hook-map.md", True),
    ("Mechanics 1 · Waves, spawning, day/night", "mechanics/01-waves-spawning-daynight.md", False),
    ("Mechanics 2 · Economy, building, upgrades", "mechanics/02-economy-building-upgrades.md", False),
    ("Mechanics 3 · Combat, units, targeting", "mechanics/03-combat-units-targeting.md", False),
    ("Mechanics 4 · Flow, UI, progression", "mechanics/04-flow-ui-progression.md", False),
    ("Autonomy guide", "09-autonomy-guide.md", False),
    ("Forward-model specification", "10-forward-model-spec.md", False),
    ("Code-map index", "11-code-map-index.md", True),
    ("Verification and coverage", "12-verification-and-coverage.md", True),
    ("Level handbook · index", "levels/README.md", True),
]
LEVELS = [(4, "Neuland_Tutorial_"), (5, "Nordfels"), (6, "Durststein"), (7, "Frostsee"), (8, "Uferwind"), (9, "Sturmklamm"), (25, "Wildbach"), (26, "Moorweg"), (27, "Freifort"), (28, "Totend")]

CSS = """
html { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
body { font-family: 'Segoe UI', Calibri, Arial, sans-serif; font-size: 10.2px; line-height: 1.42; color: #1b1f24; margin: 0; }
h1 { font-size: 22px; margin: 0 0 8px; padding-bottom: 5px; border-bottom: 2px solid #b8860b; color: #3a2a06; }
h2 { font-size: 15.5px; margin: 16px 0 6px; padding-bottom: 2px; border-bottom: 1px solid #d6cdb6; color: #3a2a06; page-break-after: avoid; }
h3 { font-size: 12.5px; margin: 12px 0 4px; color: #4a3a12; page-break-after: avoid; }
h4 { font-size: 11px; margin: 8px 0 3px; page-break-after: avoid; }
p, li { max-width: 100%; orphans: 3; widows: 3; }
a { color: #14527a; text-decoration: none; }
code { font-family: Consolas, 'Cascadia Mono', monospace; font-size: 9px; background: #f2efe6; padding: 0 2px; border-radius: 2px; word-break: break-word; }
pre { background: #f6f4ee; border: 1px solid #ddd6c2; border-radius: 3px; padding: 6px 8px; white-space: pre-wrap; word-break: break-word; page-break-inside: avoid; }
pre code { background: none; padding: 0; font-size: 8.6px; }
table { border-collapse: collapse; width: 100%; margin: 6px 0 10px; font-size: 8.6px; page-break-inside: auto; }
thead { display: table-header-group; }
tr { page-break-inside: avoid; }
th { background: #e9e2cc; text-align: left; padding: 3px 5px; border: 1px solid #cfc6ab; }
td { padding: 2px 5px; border: 1px solid #ddd6c2; vertical-align: top; word-break: break-word; }
tbody tr:nth-child(even) td { background: #faf8f2; }
img { max-width: 100%; height: auto; width: auto; display: block; margin: 6px auto; page-break-inside: avoid; break-inside: avoid; }
body.land img { max-height: 158mm; }
body.port img { max-height: 232mm; }
blockquote { margin: 6px 0; padding: 4px 10px; border-left: 3px solid #b8860b; background: #faf6e6; color: #3a3320; }
em { color: #3f3f3f; }
hr { border: 0; border-top: 1px solid #d6cdb6; margin: 12px 0; }
.cover { text-align: center; margin-top: 90px; }
.cover h1 { border: 0; font-size: 34px; }
.toc td { font-size: 11px; padding: 3px 8px; }
""" + HtmlFormatter(style="friendly").get_style_defs(".codehilite")


_HTML_OK = {"br", "sub", "sup", "em", "strong", "b", "i", "u", "code", "pre", "details", "summary", "span", "div", "p", "a", "img", "table", "thead", "tbody", "tr", "th", "td", "ul", "ol", "li",
            "hr", "h1", "h2", "h3", "h4", "kbd", "mark", "blockquote", "small"}


def protect_angle(text: str) -> str:
    """Escape <Tag> tokens that are not real HTML (e.g. MonoBehaviour<Script>) outside code spans/blocks — a stray <script> would swallow the page."""
    parts = re.split(r"(```.*?```|`[^`\n]*`)", text, flags=re.S)
    out = []
    for i, part in enumerate(parts):
        if i % 2 == 1:
            out.append(part)
            continue
        out.append(re.sub(r"<(/?)([A-Za-z][\w:-]*)([^<>\n]*)>", lambda m: m.group(0) if m.group(2).lower() in _HTML_OK else "&lt;" + m.group(1) + m.group(2) + m.group(3) + "&gt;", part))
    return "".join(out)


def to_html(md_path: str, title: str, landscape: bool = False) -> str:
    text = protect_angle(open(md_path, encoding="utf-8").read())
    base = os.path.dirname(md_path)

    def img(m):
        alt, src = m.group(1), m.group(2)
        if re.match(r"^[a-z]+://", src):
            return m.group(0)
        p = os.path.normpath(os.path.join(base, src))
        return f"![{alt}](file:///{urllib.parse.quote(p.replace(os.sep, '/'), safe='/:')})"

    text = re.sub(r"!\[([^\]]*)\]\(([^)]+)\)", img, text)
    # standalone PDFs: .md links become plain text
    text = re.sub(r"(?<!!)\[([^\]]+)\]\((?!https?://)[^)]*\.md[^)]*\)", r"\1", text)
    text = re.sub(r"(?<!!)\[([^\]]+)\]\((?!https?://|file://)[^)]*\.(?:json|csv|png|txt|ps1|py|cs)[^)]*\)", r"\1", text)
    body = markdown.markdown(text, extensions=["tables", "fenced_code", "sane_lists", "attr_list", "codehilite"], extension_configs={"codehilite": {"guess_lang": False}})
    return f"<!doctype html><html><head><meta charset='utf-8'><title>{html.escape(title)}</title><style>{CSS}</style></head><body class='{'land' if landscape else 'port'}'>{body}</body></html>"


def render(browser, html_path: str, pdf_path: str, title: str, landscape: bool):
    page = browser.new_page()
    page.goto("file:///" + html_path.replace(os.sep, "/"), wait_until="load")
    page.wait_for_timeout(250)
    page.pdf(path=pdf_path, format="A4", landscape=landscape, print_background=True, display_header_footer=True,
             margin={"top": "17mm", "bottom": "15mm", "left": "13mm", "right": "13mm"},
             header_template=f"<div style='font-size:7.5px;color:#7a6a3a;width:100%;padding:0 13mm;'>Thronefall reference pack &nbsp;·&nbsp; {html.escape(title)}</div>",
             footer_template="<div style='font-size:7.5px;color:#7a6a3a;width:100%;padding:0 13mm;display:flex;justify-content:space-between;'><span>Generated 2026-09-29 from the installed game files (build 2.13) · see verification doc</span>"
                             "<span>Page <span class='pageNumber'></span> / <span class='totalPages'></span></span></div>")
    page.close()


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", default="")
    ap.add_argument("--no-combined", action="store_true")
    a = ap.parse_args()
    os.makedirs(HTML_DIR, exist_ok=True)
    docs = [(t, os.path.join(DOCS, p), l) for t, p, l in ORDER]
    for idx, safe in LEVELS:
        pth = os.path.join(DOCS, "levels", f"{idx:02d}_{safe}.md")
        docs.append((f"Level · {safe.replace('_', ' ').strip()}", pth, True))
    docs = [d for d in docs if os.path.exists(d[1]) and a.only in d[1]]
    from playwright.sync_api import sync_playwright
    built = []
    with sync_playwright() as p:
        try:
            browser = p.chromium.launch()
        except Exception:  # noqa: BLE001
            browser = p.chromium.launch(channel="msedge")
        for title, path, landscape in docs:
            stem = os.path.splitext(os.path.relpath(path, DOCS))[0].replace(os.sep, "_")
            hp = os.path.join(HTML_DIR, stem + ".html")
            pp = os.path.join(OUT, stem + ".pdf")
            open(hp, "w", encoding="utf-8").write(to_html(path, title, landscape))
            render(browser, hp, pp, title, landscape)
            n = len(PdfReader(pp).pages)
            built.append((title, pp, n))
            print(f"{stem:60s} {n:3d} pages  {os.path.getsize(pp) / 1024:7.0f} KB")
        if not a.no_combined and not a.only:
            # cover + ToC
            page_no = 2
            rows = []
            for title, pp, n in built:
                rows.append(f"<tr><td>{html.escape(title)}</td><td style='text-align:right'>{page_no}</td></tr>")
                page_no += n
            cover = (f"<div class='cover'><h1>Thronefall — reverse-engineering reference pack</h1><p>Static extraction, mapping files and game handbook for an autonomous bot<br>"
                     f"Game build 2.13 (Unity 2022.3.62f2, Mono) · generated {datetime.date(2026, 9, 29)}</p></div><h2>Contents</h2><table class='toc'><tbody>{''.join(rows)}</tbody></table>"
                     "<p><em>Every number in this handbook was decoded from the shipped game files or computed from them; the verification chapter lists the checks and their results.</em></p>")
            hp = os.path.join(HTML_DIR, "_cover.html")
            open(hp, "w", encoding="utf-8").write(f"<!doctype html><html><head><meta charset='utf-8'><style>{CSS}</style></head><body>{cover}</body></html>")
            cp = os.path.join(OUT, "_cover.pdf")
            render(browser, hp, cp, "Cover", False)
            browser.close()
            w = PdfWriter()
            w.append(cp)
            for title, pp, n in built:
                start = len(w.pages)
                w.append(pp)
                w.add_outline_item(title, start)
            # cover counts as page 1; ToC numbers assume the cover is one page
            final = os.path.join(OUT, "Thronefall-Reference-Handbook.pdf")
            w.write(final)
            print(f"combined: {final}  {len(w.pages)} pages, {os.path.getsize(final) / 1e6:.1f} MB")
        else:
            browser.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
