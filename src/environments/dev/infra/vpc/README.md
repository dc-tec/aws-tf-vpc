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
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../../_modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | <pre>{<br>  "environment": "Dev",<br>  "managedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->