terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "transit_gateway_attachment" {
  source = "../../modules/transit_gateway_attachment"
  name   = "example-transit-gateway-attachment"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/transit_gateway_attachment/variables.tf.
}
