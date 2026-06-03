resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.description
  alarm_actions       = var.alarm_actions
  tags                = var.tags
}
