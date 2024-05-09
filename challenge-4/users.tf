data "aws_caller_identity" "current" {}

resource "aws_iam_user" "user" {
  name = "admin-user-${data.aws_caller_identity.current.account_id}"
  path = "/system/"
}

data "aws_iam_users" "users" {}

output "users_list" {
  value = data.aws_iam_users.users.names
}

output "users_total" {
  value = length(data.aws_iam_users.users.names)
}