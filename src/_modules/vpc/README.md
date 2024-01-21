<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_security_group_egress_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_internet_gateway"></a> [internet\_gateway](#input\_internet\_gateway) | Internet gateway configuration | <pre>map(object({<br>    vpc_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | NAT gateway configuration | <pre>map(object({<br>    vpc_name    = string<br>    subnet_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_route_table_associations"></a> [route\_table\_associations](#input\_route\_table\_associations) | Route table association configuration | <pre>map(object({<br>    subnet_name      = string<br>    route_table_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Route table configuration | <pre>map(object({<br>    vpc_name = string<br>    routes : list(object({<br>      cidr_block = string<br>      use_igw    = optional(bool, true)<br>      igw_name   = optional(string, "")<br>      use_ngw    = optional(bool, false)<br>      ngw_name   = optional(string, "")<br>      # use_ec2ni  = optional(bool, false)<br>      # use_vpcpc  = optional(bool, false)<br>      # use_vpce   = optional(bool, false)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | <pre>map(object({<br>    vpc_name = string<br>    ingress = map(object({<br>      from_port           = number<br>      to_port             = number<br>      protocol            = string<br>      cidr_ipv4           = optional(string)<br>      security_group_name = optional(string)<br>    }))<br>    egress = map(object({<br>      from_port           = number<br>      to_port             = number<br>      protocol            = string<br>      cidr_ipv4           = optional(string)<br>      security_group_name = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet configuration | <pre>map(object({<br>    vpc_name          = string<br>    cidr_block        = string<br>    availability_zone = string<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | <pre>{<br>  "environment": "Dev",<br>  "managedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC configuration | <pre>map(object({<br>    cidr_block           = string<br>    enable_dns           = optional(bool, true)<br>    enable_dns_hostnames = optional(bool, false)<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->