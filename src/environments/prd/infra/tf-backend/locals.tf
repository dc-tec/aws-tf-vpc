locals {
  iam_user_name = "dev-terraform"
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
}