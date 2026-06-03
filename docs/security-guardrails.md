
# Security Guardrails

## Baseline expectations

- Public S3 access blocked by default.
- Encryption enabled where practical.
- IMDSv2 required for EC2 examples.
- No credentials, tokens, internal hostnames or customer data.
- IAM examples should be minimized before production use.

## CI checks

The repository includes formatting, hygiene and public-safety checks. Heavy security scanners can be added per environment, including Checkov, Trivy, Semgrep and OPA.
