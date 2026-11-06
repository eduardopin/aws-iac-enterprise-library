# Contributing

## Your First Contribution

Start with one of the scoped tasks in
[`docs/community/GOOD_FIRST_ISSUES.md`](docs/community/GOOD_FIRST_ISSUES.md), or
choose one module and its same-named example for a focused documentation fix.

Pillow is only needed to regenerate `site/og.png` with
`scripts/render_site_assets.py`; it is not needed to use the library.

1. Read the module's `README.md`, `variables.tf` and matching file under
   `examples/` before changing behavior.
2. Keep placeholder values public-safe and update documentation when an
   interface or assumption changes.
3. Run the repository's local checks:

   ```sh
   make quality
   bash scripts/repository_review.sh
   ```

   `make quality` formats Terraform and then runs the module-hygiene and
   public-safety checks. Review any formatting changes before submitting them.
4. In the contribution description, state what changed and which security,
   reliability or cost assumption you reviewed.

## Change Expectations

- Keep pull requests focused on one operational improvement.
- Update documentation when behavior, assumptions or examples change.
- Avoid environment-specific values and sensitive data.
- Run validation before asking for review.

## Commit Style

Use specific messages such as `docs: add rollback checklist` or `feat: add cost summary script`.
