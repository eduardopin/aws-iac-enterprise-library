output "id" {
  description = "Primary resource identifier."
  value       = try(aws_config_configuration_recorder.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_config_configuration_recorder.this.arn, null)
}
