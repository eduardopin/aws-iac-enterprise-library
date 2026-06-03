output "id" {
  description = "Primary resource identifier."
  value       = try(aws_ecs_service.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_ecs_service.this.arn, null)
}
