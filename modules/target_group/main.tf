resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type
  health_check {
    path = var.health_check_path
  }
  tags = var.tags
}
