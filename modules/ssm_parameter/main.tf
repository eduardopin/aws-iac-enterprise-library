resource "aws_ssm_parameter" "this" {
  name        = var.name
  description = var.description
  type        = var.type
  value       = var.value
  key_id      = var.kms_key_id
  tags        = var.tags
}
