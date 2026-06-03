output "id" {
  description = "Primary resource identifier."
  value       = try(aws_codebuild_project.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_codebuild_project.this.arn, null)
}
