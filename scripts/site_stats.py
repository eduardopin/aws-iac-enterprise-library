#!/usr/bin/env python3
"""Print the repository counts used by the landing page."""

from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]


def collect_stats() -> dict[str, int]:
    """Return stable, named counts for the public site."""
    modules_dir = REPOSITORY_ROOT / "modules"
    examples_dir = REPOSITORY_ROOT / "examples"
    docs_dir = REPOSITORY_ROOT / "docs"

    return {
        "modules": sum(path.is_dir() for path in modules_dir.iterdir()),
        "example_files": sum(path.is_file() for path in examples_dir.rglob("*")),
        # Community launch material is separate from the top-level engineering guides.
        "docs": sum(
            path.is_file() and path.suffix == ".md" for path in docs_dir.iterdir()
        ),
    }


def main() -> None:
    for name, value in collect_stats().items():
        print(f"{name}={value}")


if __name__ == "__main__":
    main()
