resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
  cors_configuration {
    allow_methods = var.cors_allow_methods
    allow_origins = var.cors_allow_origins
  }
  tags = var.tags
}
