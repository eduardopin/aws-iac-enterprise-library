resource "aws_opensearch_domain" "this" {
  domain_name    = var.name
  engine_version = var.engine_version

  cluster_config {
    instance_type  = var.instance_type
    instance_count = var.instance_count
  }

  encrypt_at_rest {
    enabled = true
  }
  node_to_node_encryption {
    enabled = true
  }
  tags = var.tags
}
