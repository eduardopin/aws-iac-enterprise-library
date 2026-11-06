#!/usr/bin/env python3
"""Render landing-page assets (og.png and the validation capture); needs Pillow to run at all."""

from __future__ import annotations

import html
import socket
import subprocess
import tempfile
from pathlib import Path
from textwrap import wrap

from PIL import Image, ImageDraw, ImageFont

from site_stats import REPOSITORY_ROOT, collect_stats


SITE_DIR = REPOSITORY_ROOT / "site"
CAPTURE_PATH = SITE_DIR / "img" / "validation-capture.svg"
OG_PATH = SITE_DIR / "og.png"


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


def load_font(size: int, *, bold: bool = False) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    """Use a system font when available, with Pillow's bundled fallback."""
    filename = "DejaVuSans-Bold.ttf" if bold else "DejaVuSans.ttf"
    candidates = (
        Path("/usr/share/fonts/truetype/dejavu") / filename,
        Path("/usr/share/fonts") / filename,
    )
    for candidate in candidates:
        if candidate.exists():
            return ImageFont.truetype(str(candidate), size=size)
    return ImageFont.load_default(size=size)


def render_social_card() -> None:
    """Render the 1280x640 Open Graph card without external assets."""
    stats = collect_stats()
    width, height = 1280, 640
    image = Image.new("RGB", (width, height), "#0b0f17")
    draw = ImageDraw.Draw(image)

    for y in range(height):
        blend = y / height
        color = (
            int(11 + (23 - 11) * blend),
            int(15 + (20 - 15) * blend),
            int(23 + (38 - 23) * blend),
        )
        draw.line((0, y, width, y), fill=color)

    for x in range(40, width, 80):
        draw.line((x, 0, x, height), fill="#1d2635", width=1)
    for y in range(0, height, 80):
        draw.line((0, y, width, y), fill="#1d2635", width=1)

    connections = [
        ((865, 120), (1045, 205)),
        ((1045, 205), (930, 330)),
        ((930, 330), (1110, 445)),
        ((1045, 205), (1170, 130)),
        ((930, 330), (795, 455)),
    ]
    for start, end in connections:
        draw.line((*start, *end), fill="#6d5ab5", width=4)
    for index, (x, y) in enumerate(
        [(865, 120), (1045, 205), (930, 330), (1110, 445), (1170, 130), (795, 455)]
    ):
        radius = 20 if index in {1, 2} else 13
        draw.ellipse((x - radius, y - radius, x + radius, y + radius), fill="#ffad42")
        draw.ellipse(
            (x - radius + 5, y - radius + 5, x + radius - 5, y + radius - 5),
            fill="#151b28",
        )

    eyebrow = load_font(25, bold=True)
    title = load_font(61, bold=True)
    subtitle = load_font(29)
    stat_font = load_font(24, bold=True)
    small = load_font(19)

    draw.rounded_rectangle((58, 58, 440, 105), radius=23, fill="#2c2448")
    draw.text((83, 68), "TERRAFORM · AWS FOUNDATIONS", font=eyebrow, fill="#d8cbff")
    draw.multiline_text(
        (58, 150),
        "AWS IaC\nEnterprise Library",
        font=title,
        fill="#f7f9fc",
        spacing=2,
    )
    draw.text(
        (62, 325),
        "Small modules. Explicit interfaces. Reviewable examples.",
        font=subtitle,
        fill="#bdc9d9",
    )

    stats_text = (
        f"{stats['modules']} MODULES    "
        f"{stats['example_files']} EXAMPLE FILES    "
        f"{stats['docs']} GUIDES"
    )
    draw.rounded_rectangle((58, 415, 742, 481), radius=14, fill="#161d2a", outline="#354158", width=2)
    draw.text((83, 434), stats_text, font=stat_font, fill="#ffbd66")
    draw.text(
        (62, 548),
        "github.com/eduardopin/aws-iac-enterprise-library",
        font=small,
        fill="#8fa0b6",
    )

    OG_PATH.parent.mkdir(parents=True, exist_ok=True)
    image.save(OG_PATH, format="PNG", optimize=True)


def main() -> None:
    render_capture(run_offline_validation())
    render_social_card()
    print(f"rendered {CAPTURE_PATH.relative_to(REPOSITORY_ROOT)}")
    print(f"rendered {OG_PATH.relative_to(REPOSITORY_ROOT)}")


if __name__ == "__main__":
    main()
