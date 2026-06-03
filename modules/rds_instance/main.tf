resource "aws_db_instance" "this" {
  identifier              = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  username                = var.username
  password                = var.password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.security_group_ids
  storage_encrypted       = true
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  tags                    = var.tags
}
