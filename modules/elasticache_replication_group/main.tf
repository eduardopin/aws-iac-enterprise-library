resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.name
  description                = var.description
  engine                     = "redis"
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_clusters
  subnet_group_name          = var.subnet_group_name
  security_group_ids         = var.security_group_ids
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  tags                       = var.tags
}
