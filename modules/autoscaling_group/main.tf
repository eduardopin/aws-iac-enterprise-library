resource "aws_autoscaling_group" "this" {
  name                = var.name
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}
