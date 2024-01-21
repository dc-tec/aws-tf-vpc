# Terraform AWS Infrastructure

This repository contains Terraform code for provisioning AWS infrastructure, including a VPC and EC2 instances.

## Prerequisites

- Terraform >= 1.1.0
- AWS Provider ~> 5.0

## Modules

This Terraform configuration includes the following modules:

### VPC Module

The VPC module creates a VPC and related networking components. It takes the following inputs:

- `vpc_config`: Configuration for the VPC.
- `sn_config`: Configuration for the subnets.
- `igw_config`: Configuration for the internet gateway.
- `ngw_config`: Configuration for the NAT gateway.
- `rt_config`: Configuration for the route tables.
- `rta_config`: Configuration for the route table associations.
- `sg_config`: Configuration for the security groups.

## Usage
Before you run, make sure that you have a IAM account in AWS with access and secret keys. Set these as environment variables:
```
 export AWS_ACCESS_KEY_ID=<ACCES_KEY_ID>
 export AWS_SECRET_ACCESS_KEY=<ACCESS_KEY>
```

To use this Terraform configuration, first initialize your Terraform workspace:
```
terraform init
```

Then, create a plan:
```
terraform plan -var-file=vars/vpc-dev.tfvars -var-file=vars/ec2-dev.tfvars
```

If the plan looks good, apply it:
```
terraform apply -var-file=vars/vpc-dev.tfvars -var-file=vars/ec2-dev.tfvars
```

### Contributing
Contributions to this repository are welcome. Please make sure to test your changes thoroughly before submitting a pull request.

### License
This project is licensed under the MIT License. See the LICENSE file for details.
