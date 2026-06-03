output "id" {
  description = "Primary resource identifier."
  value       = try(aws_cloudfront_distribution.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_cloudfront_distribution.this.arn, null)
}
