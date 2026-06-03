output "id" {
  description = "Primary resource identifier."
  value       = try(aws_scheduler_schedule.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_scheduler_schedule.this.arn, null)
}
