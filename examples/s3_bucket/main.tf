terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"
  name   = "example-s3-bucket"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/s3_bucket/variables.tf.
}
