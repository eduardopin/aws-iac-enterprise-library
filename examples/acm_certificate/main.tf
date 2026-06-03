terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "acm_certificate" {
  source = "../../modules/acm_certificate"
  name   = "example-acm-certificate"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/acm_certificate/variables.tf.
}
