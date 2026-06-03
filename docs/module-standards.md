
# Module Standards

## Standard structure

Each module follows the standard Terraform module layout:

- `main.tf`
- `variables.tf`
- `outputs.tf`
- `versions.tf`
- `README.md`

## Interface conventions

- `name` is the standard primary naming input.
- `tags` is always available for FinOps and ownership metadata.
- Resource-specific values are explicit variables, not hidden locals.
- Defaults are conservative where practical.

## Review model

These modules are public portfolio starters. Before production use, review provider versions, compliance requirements, account topology, IAM boundaries, naming conventions and organization-specific guardrails.
