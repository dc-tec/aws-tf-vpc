variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "vpc_config" {
  description = "VPC configuration"
  type = map(object({
    cidr_block           = string
    enable_dns           = optional(bool, true)
    enable_dns_hostnames = optional(bool, false)
  }))
  default = {}
}

variable "sn_config" {
  description = "Subnet configuration"
  type = map(object({
    vpc_name          = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {}
}

variable "igw_config" {
  description = "Internet gateway configuration"
  type = map(object({
    vpc_name = string
  }))
  default = {}
}

variable "ngw_config" {
  description = "NAT gateway configuration"
  type = map(object({
    vpc_name    = string
    subnet_name = string
  }))
  default = {}
}

variable "rt_config" {
  description = "Route table configuration"
  type = map(object({
    vpc_name = string
    routes : list(object({
      cidr_block = string
      use_igw    = optional(bool, true)
      igw_name   = optional(string, "")
      use_ngw    = optional(bool, false)
      ngw_name   = optional(string, "")
      # use_ec2ni  = optional(bool, false)
      # use_vpcpc  = optional(bool, false)
      # use_vpce   = optional(bool, false)
    }))
  }))
  default = {}
}

variable "rta_config" {
  description = "Route table association configuration"
  type = map(object({
    subnet_name      = string
    route_table_name = string
  }))
  default = {}
}

variable "sg_config" {
  type = map(object({
    vpc_name = string
    ingress = map(object({
      from_port           = number
      to_port             = number
      protocol            = string
      cidr_ipv4           = optional(string)
      security_group_name = optional(string)
    }))
    egress = map(object({
      from_port           = number
      to_port             = number
      protocol            = string
      cidr_ipv4           = optional(string)
      security_group_name = optional(string)
    }))
  }))
  default = {}
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    environment = "Dev"
    managedBy   = "Terraform"
  }
}