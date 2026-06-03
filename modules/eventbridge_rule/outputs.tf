output "id" {
  description = "Primary resource identifier."
  value       = try(aws_cloudwatch_event_rule.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_cloudwatch_event_rule.this.arn, null)
}
