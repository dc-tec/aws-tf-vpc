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

data "aws_iam_user" "main" {
  user_name = local.iam_user_name
}

data "aws_iam_policy_document" "main" {
  for_each = local.s3_config_yaml

  statement {
    sid    = "ListObjectsInBucket"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_iam_user.main.arn}"]
    }

    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::s3-${each.value.bucket}-${data.aws_region.current.name}"]
  }

  statement {
    sid    = "ReadWriteObjectsInBucket"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_iam_user.main.arn}"]
    }

    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::s3-${each.value.bucket}-${data.aws_region.current.name}/*"]
  }
}

module "s3" {
  source  = "app.terraform.io/deCort-tech/s3/aws"
  version = "1.0.0"

  ## S3 configuration
  s3_config = local.s3_config
}