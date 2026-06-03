terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "elasticache_replication_group" {
  source = "../../modules/elasticache_replication_group"
  name   = "example-elasticache-replication-group"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/elasticache_replication_group/variables.tf.
}
