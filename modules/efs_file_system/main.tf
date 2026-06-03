resource "aws_efs_file_system" "this" {
  encrypted        = true
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  tags             = merge(var.tags, { Name = var.name })
}
