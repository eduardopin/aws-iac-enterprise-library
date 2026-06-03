output "id" {
  description = "Primary resource identifier."
  value       = try(aws_sfn_state_machine.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_sfn_state_machine.this.arn, null)
}
