output "id" {
  description = "Primary resource identifier."
  value       = try(aws_rds_cluster.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_rds_cluster.this.arn, null)
}
