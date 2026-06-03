output "id" {
  description = "Primary resource identifier."
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this.arn, null)
}
