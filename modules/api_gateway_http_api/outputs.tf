output "id" {
  description = "Primary resource identifier."
  value       = try(aws_apigatewayv2_api.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_apigatewayv2_api.this.arn, null)
}
