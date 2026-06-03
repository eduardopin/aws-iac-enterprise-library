output "id" {
  description = "Primary resource identifier."
  value       = try(aws_eks_cluster.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_eks_cluster.this.arn, null)
}
