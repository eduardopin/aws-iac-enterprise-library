resource "aws_scheduler_schedule" "this" {
  name       = var.name
  group_name = var.group_name

  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = var.schedule_expression

  target {
    arn      = var.target_arn
    role_arn = var.role_arn
    input    = var.input
  }
}
