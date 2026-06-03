output "id" {
  description = "Primary resource identifier."
  value       = try(aws_wafv2_web_acl.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_wafv2_web_acl.this.arn, null)
}
