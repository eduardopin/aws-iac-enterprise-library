output "id" {
  description = "Primary resource identifier."
  value       = try(aws_sqs_queue.this.id, null)
}

output "arn" {
  description = "Primary resource ARN when available."
  value       = try(aws_sqs_queue.this.arn, null)
}
