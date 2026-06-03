output "id" {
  description = "Primary resource identifier."
  value       = try(aws_opensearch_domain.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_opensearch_domain.this.arn, null)
}
