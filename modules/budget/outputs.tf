output "id" {
  description = "Primary resource identifier."
  value       = try(aws_budgets_budget.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_budgets_budget.this.arn, null)
}
