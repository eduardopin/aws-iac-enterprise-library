output "id" {
  description = "Primary resource identifier."
  value       = try(aws_security_group.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_security_group.this.arn, null)
}
