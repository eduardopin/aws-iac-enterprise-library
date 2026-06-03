output "id" {
  description = "Primary resource identifier."
  value       = try(aws_s3_bucket.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_s3_bucket.this.arn, null)
}
