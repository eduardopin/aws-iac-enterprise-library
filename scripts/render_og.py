#!/usr/bin/env python3
"""Render site/og.png (1200x630) from HTML with headless Chrome.

Pin Open social-image spec: ``ground`` light, the page's real favicon at 96px
with a 64px inset, the h1 in Archivo 780 at 64px, one 8px rule in the page's
``accent-fill`` (violet), the counts from ``site_stats.py`` and the URL in
Martian Mono 24px in ``ink-muted``. Text stays inside the central 1080x510.
No screenshot, gradient or star count.

Needs Google Chrome or Chromium (``CHROME`` overrides the binary) and network
access to Google Fonts. Standard library only; run by hand after a change and
commit the PNG.
"""

from __future__ import annotations

import os
import shutil
import struct
import subprocess
import tempfile
from pathlib import Path

from site_stats import REPOSITORY_ROOT, collect_stats

SITE = REPOSITORY_ROOT / "site"
OUTPUT = SITE / "og.png"
WIDTH, HEIGHT = 1200, 630
# Pin Open 1.0.0 light values (assets/pin-open-1.0.0.css): ground, ink, ink-muted, violet.
GROUND, INK, INK_MUTED, VIOLET = "#f3f3f0", "#15181b", "#4d555b", "#5c4199"
FONTS_URL = (
    "https://fonts.googleapis.com/css2?family=Archivo:wdth,wght@62..125,100..900"
    "&family=Martian+Mono:wdth,wght@75..112.5,100..800&display=block"
)


def page() -> str:
    stats = collect_stats()
    counts = (
        f"{stats['modules']} modules · {stats['example_files']} example files · "
        f"{stats['docs']} engineering guides"
    )
    return f"""<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="{FONTS_URL}">
<style>
html,body{{margin:0;width:{WIDTH}px;height:{HEIGHT}px;overflow:hidden;background:{GROUND};color:{INK};font-family:Archivo,sans-serif}}
.fav{{position:absolute;left:64px;top:64px;width:96px;height:96px}}
.name{{position:absolute;left:192px;top:96px;margin:0;font-size:28px;font-weight:680}}
h1{{position:absolute;left:64px;top:210px;margin:0;font-size:64px;line-height:.94;font-weight:780;font-stretch:118%;letter-spacing:-.035em}}
.rule{{position:absolute;left:64px;top:304px;width:264px;height:8px;background:{VIOLET}}}
.counts{{position:absolute;left:64px;top:352px;margin:0;font-size:28px;font-weight:600}}
.url{{position:absolute;left:64px;top:500px;font-family:"Martian Mono",monospace;font-size:24px;color:{INK_MUTED}}}
</style></head><body>
<img class="fav" src="{(SITE / "favicon.svg").as_uri()}" alt="">
<p class="name">AWS IaC Enterprise Library</p>
<h1>Terraform modules for AWS.</h1><div class="rule"></div>
<p class="counts">{counts}</p>
<div class="url">eduardopin.github.io/aws-iac-enterprise-library</div>
</body></html>"""


def chrome() -> str:
    for candidate in (os.environ.get("CHROME"), "google-chrome", "chromium", "chromium-browser"):
        if candidate and shutil.which(candidate):
            return shutil.which(candidate)  # type: ignore[return-value]
    raise SystemExit("Chrome or Chromium not found; set CHROME to its path")


def png_size(path: Path) -> tuple[int, int]:
    header = path.read_bytes()[:24]
    if header[:8] != b"\x89PNG\r\n\x1a\n":
        raise SystemExit(f"{path} is not a PNG")
    return struct.unpack(">II", header[16:24])


def main() -> None:
    with tempfile.TemporaryDirectory() as tmp:
        html = Path(tmp) / "og.html"
        html.write_text(page(), encoding="utf-8")
        shot = Path(tmp) / "og.png"
        subprocess.run(
            [chrome(), "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
             f"--window-size={WIDTH},{HEIGHT}", "--virtual-time-budget=10000", f"--user-data-dir={tmp}/profile",
             f"--screenshot={shot}", html.as_uri()],
            check=True, capture_output=True,
        )
        if png_size(shot) != (WIDTH, HEIGHT):
            raise SystemExit(f"rendered {png_size(shot)}, expected {(WIDTH, HEIGHT)}")
        shutil.copyfile(shot, OUTPUT)
    print(f"wrote {OUTPUT.relative_to(REPOSITORY_ROOT)} {WIDTH}x{HEIGHT}, {OUTPUT.stat().st_size} bytes")


if __name__ == "__main__":
    main()
