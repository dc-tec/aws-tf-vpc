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

module "vpc" {
  source = "./_modules/vpc"

  ## VPC configuration
  vpc_config = local.vpc_config

  ## Subnet configuration
  sn_config = local.sn_config

  ## Internet gateway configuration
  igw_config = local.igw_config

  ## NAT gateway configuration
  ngw_config = local.ngw_config

  ## Route table configuration
  rt_config = local.rt_config

  ## Route table association configuration
  rta_config = local.rta_config

  ## Security group configuration
  sg_config = local.sg_config
}