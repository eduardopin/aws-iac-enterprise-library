output "id" {
  description = "Primary resource identifier."
  value       = try(aws_route53_record.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_route53_record.this.arn, null)
}
