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
  source  = "app.terraform.io/deCort-tech/vpc/aws"
  version = "1.0.0"

  ## VPC configuration
  vpc                      = local.vpc_config
  subnets                  = local.sn_config
  internet_gateway         = local.igw_config
  nat_gateway              = local.ngw_config
  route_tables             = local.rt_config
  route_table_associations = local.rta_config
  security_groups          = local.sg_config

}