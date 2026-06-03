output "id" {
  description = "Primary resource identifier."
  value       = try(aws_lb_listener.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_lb_listener.this.arn, null)
}
