output "id" {
  description = "Primary resource identifier."
  value       = try(aws_efs_file_system.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_efs_file_system.this.arn, null)
}
