output "id" {
  description = "Primary resource identifier."
  value       = try(aws_kms_key.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_kms_key.this.arn, null)
}
