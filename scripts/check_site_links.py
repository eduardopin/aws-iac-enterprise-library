#!/usr/bin/env python3
"""Check local links and document anchors used by the landing-page change."""

from __future__ import annotations

import re
import sys
from html.parser import HTMLParser
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
SITE_PATH = REPOSITORY_ROOT / "site" / "index.html"
MARKDOWN_PATHS = [
    REPOSITORY_ROOT / "README.md",
    REPOSITORY_ROOT / "CONTRIBUTING.md",
    *sorted((REPOSITORY_ROOT / "docs" / "community").glob("*.md")),
]
REMOTE_PREFIXES = ("http://", "https://", "mailto:", "data:")


class ReferenceParser(HTMLParser):
    """Collect ids, links and assets from HTML."""

    def __init__(self) -> None:
        super().__init__()
        self.ids: list[str] = []
        self.references: list[tuple[str, str]] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        del tag
        values = dict(attrs)
        if values.get("id"):
            self.ids.append(values["id"] or "")
        for attribute in ("href", "src"):
            if values.get(attribute):
                self.references.append((attribute, values[attribute] or ""))


def check_site_html(errors: list[str]) -> tuple[int, int]:
    parser = ReferenceParser()
    parser.feed(SITE_PATH.read_text(encoding="utf-8"))
    known_ids: set[str] = set()

    for element_id in parser.ids:
        if element_id in known_ids:
            errors.append(f"site/index.html: duplicate id #{element_id}")
        known_ids.add(element_id)

    checked = 0
    for attribute, reference in parser.references:
        if reference.startswith(REMOTE_PREFIXES):
            continue
        checked += 1
        if reference.startswith("#"):
            if reference[1:] not in known_ids:
                errors.append(f"site/index.html: missing anchor {reference}")
            continue
        target = SITE_PATH.parent / reference.split("#", maxsplit=1)[0]
        if not target.exists():
            errors.append(
                f"site/index.html: missing local {attribute} target {reference}"
            )
    return len(parser.ids), checked


def markdown_anchors(text: str) -> set[str]:
    anchors = set()
    for match in re.finditer(r"^#{1,6}\s+(.+)$", text, re.MULTILINE):
        heading = match.group(1).strip().lower()
        heading = re.sub(r"[^a-z0-9 _-]", "", heading)
        anchors.add(heading.replace(" ", "-"))
    return anchors


def check_markdown(errors: list[str]) -> int:
    markdown_link = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
    html_reference = re.compile(r'(?:href|src)="([^"]+)"')
    checked = 0

    for path in MARKDOWN_PATHS:
        text = path.read_text(encoding="utf-8")
        anchors = markdown_anchors(text)
        references = markdown_link.findall(text) + html_reference.findall(text)
        for reference in references:
            reference = reference.strip().split()[0].strip("<>")
            if reference.startswith(REMOTE_PREFIXES):
                continue
            checked += 1
            if reference.startswith("#"):
                if reference[1:] not in anchors:
                    errors.append(f"{path.relative_to(REPOSITORY_ROOT)}: missing {reference}")
                continue
            local_path, _, _anchor = reference.partition("#")
            target = (path.parent / local_path).resolve()
            try:
                target.relative_to(REPOSITORY_ROOT)
            except ValueError:
                errors.append(
                    f"{path.relative_to(REPOSITORY_ROOT)}: link escapes repository: "
                    f"{reference}"
                )
                continue
            if not target.exists():
                errors.append(
                    f"{path.relative_to(REPOSITORY_ROOT)}: missing local link "
                    f"{reference}"
                )
    return checked


def main() -> None:
    errors: list[str] = []
    site_ids, site_references = check_site_html(errors)
    markdown_references = check_markdown(errors)

    if errors:
        print("\n".join(errors), file=sys.stderr)
        raise SystemExit(1)

    document_count = len(MARKDOWN_PATHS) + 1
    print(f"Link and anchor check OK across {document_count} documents")
    print(
        f"Checked {site_ids} site ids and "
        f"{site_references + markdown_references} local references"
    )


if __name__ == "__main__":
    main()
