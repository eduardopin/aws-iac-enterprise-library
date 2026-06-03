resource "aws_eks_addon" "this" {
  cluster_name                = var.cluster_name
  addon_name                  = var.addon_name
  addon_version               = var.addon_version
  resolve_conflicts_on_update = "OVERWRITE"
  tags                        = var.tags
}
