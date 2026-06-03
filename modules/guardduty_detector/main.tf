resource "aws_guardduty_detector" "this" {
  enable = var.enable
  tags   = var.tags
}
