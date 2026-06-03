output "id" {
  description = "Primary resource identifier."
  value       = try(aws_ssm_parameter.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_ssm_parameter.this.arn, null)
}
