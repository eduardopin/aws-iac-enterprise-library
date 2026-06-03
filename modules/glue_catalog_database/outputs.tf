output "id" {
  description = "Primary resource identifier."
  value       = try(aws_glue_catalog_database.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_glue_catalog_database.this.arn, null)
}
