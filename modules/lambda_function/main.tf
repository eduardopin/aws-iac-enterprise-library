resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_lambda_function" "this" {
  function_name = var.name
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.filename
  timeout       = var.timeout
  memory_size   = var.memory_size

  tracing_config {
    mode = var.tracing_mode
  }
  tags = var.tags

  depends_on = [aws_cloudwatch_log_group.this]
}
