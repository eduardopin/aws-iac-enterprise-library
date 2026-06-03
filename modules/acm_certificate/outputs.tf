output "id" {
  description = "Primary resource identifier."
  value       = try(aws_acm_certificate.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_acm_certificate.this.arn, null)
}
