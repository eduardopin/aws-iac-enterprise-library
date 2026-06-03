#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Exclude this scanner and workflows to avoid false positives caused by the scanner's own patterns.
exclude_args=(--exclude-dir=.git --exclude="public_safety_audit.sh" --exclude="terraform-quality.yml")

patterns=(
  'AKIA[0-9A-Z]{16}'
  'aws_secret_access_key'
  'BEGIN RSA PRIVATE KEY'
  'BEGIN OPENSSH PRIVATE KEY'
  'ghp_[A-Za-z0-9_]{30,}'
  'xox[baprs]-[A-Za-z0-9-]+'
)

for pattern in "${patterns[@]}"; do
  if grep -RInE "$pattern" . "${exclude_args[@]}"; then
    echo "Potential secret pattern found. Review before publishing."
    exit 1
  fi
done

echo "Public safety audit OK"
