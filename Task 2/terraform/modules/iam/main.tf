variable "role_name" {}
variable "secrets" { type = map(string) }

resource "aws_iam_role" "role" {
  name = var.role_name
}

resource "aws_secretsmanager_secret" "secrets" {
  for_each = var.secrets
  name     = each.key
}

output "role_arn" {
  value = aws_iam_role.role.arn
}