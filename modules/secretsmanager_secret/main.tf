resource "aws_secretsmanager_secret" "this" {
  name        = var.name
  description = var.description
  kms_key_id  = var.kms_key_id
  tags        = var.tags
}
