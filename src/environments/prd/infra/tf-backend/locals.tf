locals {
  iam_user_name  = "dev-terraform"

  s3_config_yaml = yamldecode(file("_configuration/tf_state_s3.yaml.tftpl")).s3_config

  s3_config = {
    for key, value in local.s3_config_yaml :
    key => {
      bucket           = value.bucket
      acl              = value.acl
      versioning       = value.versioning
      object_ownership = value.object_ownership
    }
  }

  iam_policy_yaml = yamldecode(templatefile("_configuration/tf_state_s3.yaml.tftpl", {
      user_arn            = data.aws_iam_user.main.arn
      bucket_name         = "s3-tf-state-bucket-${data.aws_region.current.name}"
      region_name         = data.aws_region.current.name
      account_id          = data.aws_caller_identity.current.account_id
      dynamodb_table_name = aws_dynamodb_table.main.name
    })).iam_config.policies
  

  iam_policies = {
    for policy_key, policy in local.iam_policy_yaml : policy_key => {
      statements = [
        for statement in policy.statements : {
          sid       = lookup(statement, "sid", null)
          effect    = statement.effect
          principals = contains(keys(statement), "principals") ? [
            for principal in statement.principals : {
              type       = principal.type
              identifier = principal.identifier
            }
          ] : []
          actions   = lookup(statement, "actions", null)
          resources = lookup(statement, "resources", null)
        }
      ]
    }
  }

  iam_role_yaml = yamldecode(file("_configuration/tf_state_s3.yaml.tftpl")).iam_config.roles

  iam_roles = {
    for role_key, role_value in local.iam_role_yaml : role_key => {
      name               = role_value.name
      description        = role_value.description
      assume_role_policy = role_value.assume_role_policy
      policy_to_attach   = role_value.policy_to_attach
    }
  }
}