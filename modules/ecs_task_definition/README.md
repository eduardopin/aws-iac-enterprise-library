# Ecs Task Definition Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-Module-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-containers-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Status](https://img.shields.io/badge/Status-Portfolio%20Starter-111827?style=for-the-badge)

## Purpose

ECS task definition starter.

This module is part of the **AWS IaC Enterprise Library** portfolio. It is designed as a clean, reusable and readable starting point for infrastructure teams.

## Design principles

- Secure defaults where practical.
- Consistent `name` and `tags` interface.
- Small module surface area.
- Easy review by humans and ATS/recruiters.
- No company-specific code, credentials or private architecture.

## Example

```hcl
module "ecs_task_definition" {
  source = "../../modules/ecs_task_definition"
  name   = "example-ecs-task-definition"
  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }
}
```

## Files

| File | Purpose |
|---|---|
| `main.tf` | Resource implementation starter. |
| `variables.tf` | Public module interface. |
| `outputs.tf` | Standard module outputs. |
| `versions.tf` | Terraform and provider constraints. |

## Review checklist

- [ ] Naming convention reviewed.
- [ ] Tags aligned with FinOps policy.
- [ ] Encryption and retention reviewed.
- [ ] IAM permissions minimized.
- [ ] Observability requirements mapped.
- [ ] Rollback plan documented when used in a real environment.
