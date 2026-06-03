terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "cloudwatch_metric_alarm" {
  source = "../../modules/cloudwatch_metric_alarm"
  name   = "example-cloudwatch-metric-alarm"

  tags = {
    Environment = "dev"
    Owner       = "platform"
    ManagedBy   = "terraform"
  }

  # Add required inputs for real use. See modules/cloudwatch_metric_alarm/variables.tf.
}
