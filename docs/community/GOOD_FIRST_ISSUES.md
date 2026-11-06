# Good First Issue Drafts

These are small, verified gaps that the repository owner can turn into GitHub
issues. Suggested labels are proposals; contributors should use the labels that
exist in the repository when an issue is opened.

## 1. Add local parity for the CI Terraform format check

**Suggested labels:** `good first issue`, `testing`, `terraform`

`.github/workflows/terraform-quality.yml` already runs
`terraform fmt -check -recursive`, while `Makefile` has a `fmt` target that
rewrites files but no local non-writing equivalent.

**Acceptance criteria**

- Add a `make fmt-check` target that mirrors the
  `terraform fmt -check -recursive` command in
  `.github/workflows/terraform-quality.yml` without modifying files.
- Document when to use `fmt` versus `fmt-check` in `CONTRIBUTING.md`.
- Run the new target successfully across the repository.

## 2. Complete the EC2 example's required inputs

**Suggested labels:** `good first issue`, `documentation`, `terraform`

`modules/ec2_instance/variables.tf` requires `ami_id` and `subnet_id`, but
`examples/ec2_instance/main.tf` does not pass either input.

**Acceptance criteria**

- Add public-safe placeholder inputs without account IDs or environment data.
- Explain which placeholders adopters must replace.
- Make the example pass `terraform validate` after provider initialization.

## 3. Complete the ALB example's required subnet input

**Suggested labels:** `good first issue`, `documentation`, `terraform`

`modules/alb/variables.tf` requires `subnet_ids`, but
`examples/alb/main.tf` omits it.

**Acceptance criteria**

- Pass a clearly marked placeholder list for `subnet_ids`.
- Keep the example generic and public-safe.
- Make the example pass `terraform validate` after provider initialization.

## 4. Make VPC variable descriptions useful to callers

**Suggested labels:** `good first issue`, `documentation`, `terraform`

The descriptions in `modules/vpc/variables.tf` are currently `Name.`, `Tags.`
and `Cidr block.`, which repeat the variable names without explaining their
effect.

**Acceptance criteria**

- Explain how `name` is applied to the resource.
- Explain the expected purpose of `tags`.
- Describe the expected CIDR notation for `cidr_block` without prescribing an
  organization-specific range.

## 5. Validate the VPC CIDR input

**Suggested labels:** `good first issue`, `validation`, `terraform`

`modules/vpc/variables.tf` exposes `cidr_block` but has no Terraform
`validation` block.

**Acceptance criteria**

- Add validation using Terraform's CIDR functions.
- Include a clear error message for invalid input.
- Add one valid and one invalid automated test case, or document a reproducible
  validation check if a test harness is introduced separately.

## 6. Remove VPC's unused local provider requirement

**Suggested labels:** `good first issue`, `dependencies`, `terraform`

`modules/vpc/versions.tf` declares `hashicorp/local`, while
`modules/vpc/main.tf` contains only an `aws_vpc` resource.

**Acceptance criteria**

- Remove only the unused local provider requirement from the VPC module.
- Keep the AWS provider and Terraform constraints intact.
- Run formatting and validate the VPC example after initialization.

## 7. Correct initialisms in the VPC module README

**Suggested labels:** `good first issue`, `documentation`

`modules/vpc/README.md` starts with `Vpc Terraform Module`, while the resource,
directory and domain convention use `VPC`.

**Acceptance criteria**

- Use `VPC` consistently in the title and prose.
- Do not change Terraform identifiers such as the `vpc` module label.
- Check the rendered Markdown for broken headings or links.

## 8. Detect examples that omit required module inputs

**Suggested labels:** `good first issue`, `testing`, `terraform`

A tree audit finds 34 same-named examples that omit at least one module variable
with no default. For example, `examples/ec2_instance/main.tf` omits `ami_id` and
`subnet_id`, and `examples/alb/main.tf` omits `subnet_ids`.

**Acceptance criteria**

- Add a lightweight check that compares required variables with the matching
  example's module block.
- Print the example path and missing variable names on failure.
- Add the check to the documented local validation flow.

## 9. Extend module hygiene to require matching examples

**Suggested labels:** `good first issue`, `testing`, `python`

`tools/module_hygiene_check.py` verifies the five standard files in every
module, but it does not check that `examples/<module>/main.tf` exists. The
current tree has a match for all 58 modules.

**Acceptance criteria**

- Fail with a clear path when a module lacks its same-named example.
- Preserve the existing five standard-file checks.
- Keep the script dependency-free and runnable with `make hygiene`.
