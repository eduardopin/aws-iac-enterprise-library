terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "config_configuration_recorder" {
  source = "../../modules/config_configuration_recorder"
  name   = "example-config-configuration-recorder"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/config_configuration_recorder/variables.tf.
}
