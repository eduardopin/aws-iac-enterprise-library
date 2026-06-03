resource "aws_codebuild_project" "this" {
  name         = var.name
  service_role = var.service_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  source {
    type = var.source_type
  }
  tags = var.tags
}
