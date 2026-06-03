output "id" {
  description = "Primary resource identifier."
  value       = try(aws_backup_plan.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_backup_plan.this.arn, null)
}
