output "id" {
  description = "Primary resource identifier."
  value       = try(aws_internet_gateway.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_internet_gateway.this.arn, null)
}
