output "id" {
  description = "Primary resource identifier."
  value       = try(aws_route53_zone.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_route53_zone.this.arn, null)
}
