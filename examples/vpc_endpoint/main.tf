terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_endpoint" {
  source = "../../modules/vpc_endpoint"
  name   = "example-vpc-endpoint"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/vpc_endpoint/variables.tf.
}
