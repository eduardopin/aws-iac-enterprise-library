output "id" {
  description = "Primary resource identifier."
  value       = try(aws_guardduty_detector.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_guardduty_detector.this.arn, null)
}
