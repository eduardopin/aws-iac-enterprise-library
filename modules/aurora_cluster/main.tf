resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.security_group_ids
  storage_encrypted       = true
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  tags                    = var.tags
}
