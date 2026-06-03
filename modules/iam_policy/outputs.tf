output "id" {
  description = "Primary resource identifier."
  value       = try(aws_iam_policy.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_iam_policy.this.arn, null)
}
