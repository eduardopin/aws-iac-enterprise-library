resource "local_file" "karpenter_node_pool" {
  filename = "${path.module}/rendered-${var.name}-nodepool.yaml"
  content = templatefile("${path.module}/templates/nodepool.yaml.tftpl", {
    name            = var.name
    capacity_type   = var.capacity_type
    instance_family = var.instance_family
  })
}
