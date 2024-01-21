<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./_modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_instance_config"></a> [ec2\_instance\_config](#input\_ec2\_instance\_config) | EC2 instance configuration | <pre>map(object({<br>    ami                         = string<br>    instance_type               = string<br>    security_group_name         = list(string)<br>    subnet_name                 = string<br>    availability_zone           = string<br>    associate_public_ip_address = optional(bool, false)<br>    availability_zone           = string<br>  }))</pre> | `{}` | no |
| <a name="input_igw_config"></a> [igw\_config](#input\_igw\_config) | Internet gateway configuration | <pre>map(object({<br>    vpc_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_ngw_config"></a> [ngw\_config](#input\_ngw\_config) | NAT gateway configuration | <pre>map(object({<br>    vpc_name    = string<br>    subnet_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_rt_config"></a> [rt\_config](#input\_rt\_config) | Route table configuration | <pre>map(object({<br>    vpc_name = string<br>    routes : list(object({<br>      cidr_block = string<br>      use_igw    = optional(bool, false)<br>      igw_name   = optional(string, "default")<br>      use_ngw    = optional(bool, false)<br>      ngw_name   = optional(string, "default")<br>      # use_ec2ni  = optional(bool, false)<br>      # use_vpcpc  = optional(bool, false)<br>      # use_vpce   = optional(bool, false)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_rta_config"></a> [rta\_config](#input\_rta\_config) | Route table association configuration | <pre>map(object({<br>    subnet_name      = string<br>    route_table_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_sg_config"></a> [sg\_config](#input\_sg\_config) | n/a | <pre>map(object({<br>    vpc_name = string<br>    ingress = map(object({<br>      from_port           = number<br>      to_port             = number<br>      protocol            = string<br>      cidr_ipv4           = optional(string)<br>      security_group_name = optional(string)<br>    }))<br>    egress = map(object({<br>      from_port           = number<br>      to_port             = number<br>      protocol            = string<br>      cidr_ipv4           = optional(string)<br>      security_group_name = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_sn_config"></a> [sn\_config](#input\_sn\_config) | Subnet configuration | <pre>map(object({<br>    vpc_name          = string<br>    cidr_block        = string<br>    availability_zone = string<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | <pre>{<br>  "environment": "Dev",<br>  "managedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC configuration | <pre>map(object({<br>    cidr_block           = string<br>    enable_dns           = optional(bool, true)<br>    enable_dns_hostnames = optional(bool, false)<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->