output "id" {
  description = "Primary resource identifier."
  value       = try(aws_vpc_endpoint.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_vpc_endpoint.this.arn, null)
}
