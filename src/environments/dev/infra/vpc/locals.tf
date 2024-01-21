locals {
  vpc_config_yaml = yamldecode(file("_configuration/vpc.yaml")).vpc_config
  vpc_config = {
    for vpc_name, vpc_info in local.vpc_config_yaml : vpc_name => {
      cidr_block           = vpc_info.cidr_block
      enable_dns           = try(vpc_info.enable_dns, true)
      enable_dns_hostnames = try(vpc_info.enable_dns_hostnames, false)
    }
  }

  sn_config_yaml = yamldecode(file("_configuration/subnets.yaml")).sn_config
  sn_config = {
    for sn_name, sn_info in local.sn_config_yaml : sn_name => {
      vpc_name          = sn_info.vpc_name
      cidr_block        = sn_info.cidr_block
      availability_zone = sn_info.availability_zone
    }
  }

  igw_config_yaml = yamldecode(file("_configuration/networking.yaml")).igw_config
  igw_config = {
    for igw_name, igw_info in local.igw_config_yaml : igw_name => {
      vpc_name = igw_info.vpc_name
    }
  }

  ngw_config_yaml = yamldecode(file("_configuration/networking.yaml")).ngw_config
  ngw_config = {
    for ngw_name, ngw_info in local.ngw_config_yaml : ngw_name => {
      vpc_name    = ngw_info.vpc_name
      subnet_name = ngw_info.subnet_name
    }
  }

  rt_config_yaml = yamldecode(file("_configuration/route_tables.yaml")).rt_config
  rt_config = {
    for rt_name, rt_info in local.rt_config_yaml : rt_name => {
      vpc_name = rt_info.vpc_name
      routes = [
        for route_info in rt_info.routes : {
          cidr_block = route_info.cidr_block
          use_igw    = try(route_info.use_igw, true)
          igw_name   = try(route_info.igw_name, null)
          use_ngw    = try(route_info.use_ngw, false)
          ngw_name   = try(route_info.ngw_name, null)
        }
      ]
    }
  }

  rta_config_yaml = yamldecode(file("_configuration/route_tables.yaml")).rta_config
  rta_config = {
    for rta_name, rta_info in local.rta_config_yaml : rta_name => {
      subnet_name      = rta_info.subnet_name
      route_table_name = rta_info.route_table_name
    }
  }

  sg_config_yaml = yamldecode(file("_configuration/security_groups.yaml")).sg_config
  sg_config = {
    for sg_name, sg_info in local.sg_config_yaml : sg_name => {
      vpc_name = sg_info.vpc_name
      ingress = {
        for ingress_key, ingress_info in sg_info.ingress : ingress_key => {
          from_port           = ingress_info.from_port
          to_port             = ingress_info.to_port
          protocol            = ingress_info.protocol
          cidr_ipv4           = try(ingress_info.cidr_ipv4, null)
          security_group_name = try(ingress_info.security_group_name, null)
        }
      }
      egress = {
        for egress_key, egress_info in sg_info.egress : egress_key => {
          from_port           = egress_info.from_port
          to_port             = egress_info.to_port
          protocol            = egress_info.protocol
          cidr_ipv4           = try(egress_info.cidr_ipv4, null)
          security_group_name = try(egress_info.security_group_name, null)
        }
      }
    }
  }
}