output "id" {
  description = "Primary resource identifier."
  value       = try(aws_ecr_repository.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_ecr_repository.this.arn, null)
}
