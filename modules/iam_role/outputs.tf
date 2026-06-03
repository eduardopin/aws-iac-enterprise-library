output "id" {
  description = "Primary resource identifier."
  value       = try(aws_iam_role.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_iam_role.this.arn, null)
}
