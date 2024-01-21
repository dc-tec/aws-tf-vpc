locals {
  vpc_config = {
    for vpc_name, vpc_info in var.vpc_config : vpc_name => {
      cidr_block           = vpc_info.cidr_block
      enable_dns           = coalesce(vpc_info.enable_dns, true)
      enable_dns_hostnames = coalesce(vpc_info.enable_dns_hostnames, false)
    }
  }

  sn_config = {
    for sn_name, sn_info in var.sn_config : sn_name => {
      vpc_name          = sn_info.vpc_name
      cidr_block        = sn_info.cidr_block
      availability_zone = sn_info.availability_zone
    }
  }

  igw_config = {
    for igw_name, igw_info in var.igw_config : igw_name => {
      vpc_name = igw_info.vpc_name
    }
  }

  ngw_config = {
    for ngw_name, ngw_info in var.ngw_config : ngw_name => {
      vpc_name    = ngw_info.vpc_name
      subnet_name = ngw_info.subnet_name
    }
  }

  rt_config = {
    for rt_name, rt_info in var.rt_config : rt_name => {
      vpc_name = rt_info.vpc_name
      routes = [
        for route_info in rt_info.routes : {
          cidr_block = route_info.cidr_block
          use_igw    = coalesce(route_info.use_igw, true)
          igw_name   = coalesce(route_info.igw_name, "default")
          use_ngw    = coalesce(route_info.use_ngw, false)
          ngw_name   = coalesce(route_info.ngw_name, "default")
        }
      ]
    }
  }

  rta_config = {
    for rta_name, rta_info in var.rta_config : rta_name => {
      subnet_name      = rta_info.subnet_name
      route_table_name = rta_info.route_table_name
    }
  }

  sg_config = {
    for sg_name, sg_info in var.sg_config : sg_name => {
      vpc_name = sg_info.vpc_name
      ingress = {
        for ingress_key, ingress_info in sg_info.ingress : ingress_key => {
          from_port           = ingress_info.from_port
          to_port             = ingress_info.to_port
          protocol            = ingress_info.protocol
          cidr_ipv4           = ingress_info.cidr_ipv4
          security_group_name = ingress_info.security_group_name
        }
      }
      egress = {
        for egress_key, egress_info in sg_info.egress : egress_key => {
          from_port           = egress_info.from_port
          to_port             = egress_info.to_port
          protocol            = egress_info.protocol
          cidr_ipv4           = egress_info.cidr_ipv4
          security_group_name = egress_info.security_group_name
        }
      }
    }
  }

  ec2_instance_config = {
    for ec2_instance_name, ec2_instance_info in var.ec2_instance_config : ec2_instance_name => {
      ami                         = ec2_instance_info.ami
      instance_type               = ec2_instance_info.instance_type
      security_group_name         = ec2_instance_info.security_group_name
      subnet_name                 = ec2_instance_info.subnet_name
      availability_zone           = ec2_instance_info.availability_zone
      associate_public_ip_address = coalesce(ec2_instance_info.associate_public_ip_address, false)
      availability_zone           = ec2_instance_info.availability_zone
    }
  }
}