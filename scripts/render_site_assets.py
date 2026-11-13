#!/usr/bin/env python3
"""Render the landing page's validation capture SVG from a real offline run.

The social image (site/og.png) is rendered by scripts/render_og.py.
"""

from __future__ import annotations

import html
import socket
import subprocess
import tempfile
from pathlib import Path
from textwrap import wrap

from site_stats import REPOSITORY_ROOT


SITE_DIR = REPOSITORY_ROOT / "site"
CAPTURE_PATH = SITE_DIR / "img" / "validation-capture.svg"


def scrub_machine_details(text: str) -> str:
    """Remove local paths and hostname if a command happens to print them."""
    replacements = (
        (str(REPOSITORY_ROOT), "[repository]"),
        (str(Path.home()), "[home]"),
        (tempfile.gettempdir(), "[temporary directory]"),
        (socket.gethostname(), "[host]"),
    )
    for private_value, replacement in replacements:
        if private_value:
            text = text.replace(private_value, replacement)
    return text


def run_offline_validation() -> str:
    """Run the repository's offline validation targets and return real output."""
    result = subprocess.run(
        ["make", "hygiene", "safety"],
        cwd=REPOSITORY_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        timeout=60,
        check=False,
    )
    output = scrub_machine_details(result.stdout.rstrip())
    capture = f"$ make hygiene safety\n{output}"
    if result.returncode:
        raise RuntimeError(f"offline validation failed:\n{capture}")
    return capture


def render_capture(command_output: str) -> None:
    """Render terminal text as an accessible, deterministic SVG."""
    lines: list[str] = []
    for line in command_output.splitlines():
        lines.extend(wrap(line, width=92, replace_whitespace=False) or [""])

    width = 1120
    top = 112
    line_height = 30
    height = top + (len(lines) * line_height) + 48
    escaped_lines = []
    for index, line in enumerate(lines):
        fill = "#ffbd66" if line.startswith("$") else "#d7e0ed"
        escaped_lines.append(
            f'<text x="54" y="{top + index * line_height}" fill="{fill}">'
            f"{html.escape(line)}</text>"
        )

    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}" role="img" aria-labelledby="title description">
  <title id="title">Offline repository validation capture</title>
  <desc id="description">A real run of make hygiene safety in the repository root. Machine paths and hostnames are scrubbed by the renderer.</desc>
  <rect width="{width}" height="{height}" rx="20" fill="#0b0f17"/>
  <rect x="1" y="1" width="{width - 2}" height="{height - 2}" rx="19" fill="none" stroke="#354158" stroke-width="2"/>
  <circle cx="34" cy="34" r="7" fill="#ff7a68"/>
  <circle cx="58" cy="34" r="7" fill="#ffbd66"/>
  <circle cx="82" cy="34" r="7" fill="#62d49b"/>
  <text x="{width // 2}" y="41" text-anchor="middle" fill="#98a7bc" font-family="ui-monospace, SFMono-Regular, Consolas, monospace" font-size="17">repository root · offline checks</text>
  <line x1="0" y1="66" x2="{width}" y2="66" stroke="#2a3447"/>
  <g font-family="ui-monospace, SFMono-Regular, Consolas, monospace" font-size="20">
    {''.join(escaped_lines)}
  </g>
</svg>
'''
    CAPTURE_PATH.parent.mkdir(parents=True, exist_ok=True)
    CAPTURE_PATH.write_text(svg, encoding="utf-8")


def main() -> None:
    render_capture(run_offline_validation())
    print(f"rendered {CAPTURE_PATH.relative_to(REPOSITORY_ROOT)}")


if __name__ == "__main__":
    main()
