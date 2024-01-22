locals {
  iam_user_name  = "dev-terraform"

  s3_config_yaml = yamldecode(file("_configuration/tf_state_s3.yaml")).s3_config

  s3_config = {
    for key, value in local.s3_config_yaml :
    key => {
      bucket           = value.bucket
      acl              = value.acl
      versioning       = value.versioning
      object_ownership = value.object_ownership
      policy           = data.aws_iam_policy_document.main[key].json
    }
  }

  iam_policy_yaml = yamldecode(templatefile("_configuration/tf_state_s3.yaml"), {    
    user_arn            = data.aws_iam_user.main.arn
    bucket_name         = each.value.bucket
    region_name         = data.aws_region.current.name
    account_id          = data.aws_caller_identity.current.account_id
    dynamodb_table_name = aws_dynamodb_table.main.name
  }).iam_config.policies

  iam_policies = {
    for key, value in local.iam_policy_yaml :
    key => {
      statements = [
        {
          sid       = value.sid
          effect    = value.effect
          principals = can(value.principal_type) && can(value.principal_identifier) ? [
            {
              type       = value.principal_type
              identifier = value.principal_identifier
            }
          ] : []
          actions   = value.actions
          resources = value.resources
        }
      ]
    }
  }

  iam_role_yaml = yamldecode(file("_configuration/tf_state_s3.yaml")).iam_config.roles

  iam_roles = {
    for key, value in local.iam_role_yaml :
    key => {
      name               = value.name
      description        = value.description
      assume_role_policy = value.assume_role_policy
    }
  }
}