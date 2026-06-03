terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ecr_repository" {
  source = "../../modules/ecr_repository"
  name   = "example-ecr-repository"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/ecr_repository/variables.tf.
}
