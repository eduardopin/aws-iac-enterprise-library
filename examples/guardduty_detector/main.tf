terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "guardduty_detector" {
  source = "../../modules/guardduty_detector"
  name   = "example-guardduty-detector"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/guardduty_detector/variables.tf.
}
