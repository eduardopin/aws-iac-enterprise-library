#!/usr/bin/env python3
from pathlib import Path
import os
import sys

repo_root = Path(__file__).resolve().parents[1]
os.chdir(repo_root)

required = ["README.md", "main.tf", "variables.tf", "outputs.tf", "versions.tf"]
failures = []
modules_dir = Path("modules")
if not modules_dir.exists():
    failures.append("missing modules/ directory")
else:
    for module in sorted(modules_dir.iterdir()):
        if not module.is_dir():
            continue
        for file in required:
            if not (module / file).exists():
                failures.append(f"{module}: missing {file}")
if failures:
    print("Module hygiene failures:")
    print("\n".join(failures))
    sys.exit(1)
print("Module hygiene OK")
