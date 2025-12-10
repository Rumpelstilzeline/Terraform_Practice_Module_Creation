# yamldecode() => wandelt YAML-String in Terraform-Datensturktur um
# file() => liest angegebene Datei als Test ein, Ergebnis ist ein YAML-String, der noch dekodiert werden muss

# local.users_from_yaml.users => die Liste aus YAMLS
# [*].username => splat expression, um alle Usernamen zu extrahieren
# toset() => notwendig weil for_each ein Set/Map erwartet


# ignose_changes notwendig, weil sich sonst jedes Mal ein neuer User erstellen würde, wenn man die Eigenschaften ändert

locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml"))
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml.users[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "users" {
  value = local.users_from_yaml.users
}