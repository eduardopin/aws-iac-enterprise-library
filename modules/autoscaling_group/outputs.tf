output "id" {
  description = "Primary resource identifier."
  value       = try(aws_autoscaling_group.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_autoscaling_group.this.arn, null)
}
