data "aws_iam_user" "main" {
  user_name = local.iam_user_name
}

data "aws_iam_policy_document" "main" {
  for_each = local.iam_policies

  dynamic "statement" {
    for_each = each.value.statements
    content {
      sid    = statement.value.sid
      effect = statement.value.effect

      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = [principals.value.identifier]
        }
      }

      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_role" "main" {
  for_each = local.iam_roles

  name               = each.value.name
  description        = each.value.description 
  assume_role_policy = data.aws_iam_policy_document.main[each.value.assume_role_policy].json
}

resource "aws_iam_policy" "main" {
  for_each = local.iam_roles

  name        = each.value.name
  description = each.value.description
  policy      = data.aws_iam_policy_document.main[each.value.policy_to_attach].json
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each = local.iam_roles

  role       = aws_iam_role.main[each.key].name
  policy_arn = aws_iam_policy.main[each.key].arn
}