terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "api_gateway_http_api" {
  source = "../../modules/api_gateway_http_api"
  name   = "example-api-gateway-http-api"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/api_gateway_http_api/variables.tf.
}
