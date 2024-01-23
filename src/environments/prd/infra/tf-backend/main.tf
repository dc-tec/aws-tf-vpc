terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.7.0"
}

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_dynamodb_table" "main" {
  name           = "terraform-state-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  
  attribute {
      name = "LockID"
      type = "S"
  }
  
  tags = var.tags
}

module "s3" {
  source  = "app.terraform.io/deCort-tech/s3/aws"
  version = "1.1.1"

  ## S3 configuration
  s3_config = local.s3_config
}