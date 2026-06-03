terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "karpenter_node_pool" {
  source = "../../modules/karpenter_node_pool"
  name   = "example-karpenter-node-pool"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/karpenter_node_pool/variables.tf.
}
