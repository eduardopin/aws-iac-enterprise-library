output "manifest_path" {
  description = "Rendered manifest path."
  value       = local_file.karpenter_node_pool.filename
}
