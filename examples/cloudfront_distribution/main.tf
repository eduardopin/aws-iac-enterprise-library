terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "cloudfront_distribution" {
  source = "../../modules/cloudfront_distribution"
  name   = "example-cloudfront-distribution"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/cloudfront_distribution/variables.tf.
}
