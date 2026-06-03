output "id" {
  description = "Primary resource identifier."
  value       = try(aws_cloudwatch_metric_alarm.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_cloudwatch_metric_alarm.this.arn, null)
}
