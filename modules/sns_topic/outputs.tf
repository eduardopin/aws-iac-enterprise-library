output "id" {
  description = "Primary resource identifier."
  value       = try(aws_sns_topic.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_sns_topic.this.arn, null)
}
