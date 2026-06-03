output "id" {
  description = "Primary resource identifier."
  value       = try(aws_secretsmanager_secret.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_secretsmanager_secret.this.arn, null)
}
