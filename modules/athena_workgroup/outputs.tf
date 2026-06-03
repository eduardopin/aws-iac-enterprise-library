output "id" {
  description = "Primary resource identifier."
  value       = try(aws_athena_workgroup.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_athena_workgroup.this.arn, null)
}
