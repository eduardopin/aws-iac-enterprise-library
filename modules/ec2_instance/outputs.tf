output "id" {
  description = "Primary resource identifier."
  value       = try(aws_instance.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_instance.this.arn, null)
}
