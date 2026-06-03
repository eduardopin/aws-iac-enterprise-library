output "id" {
  description = "Primary resource identifier."
  value       = try(aws_cloudwatch_log_group.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_cloudwatch_log_group.this.arn, null)
}
