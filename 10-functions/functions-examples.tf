locals {
  name = "Lauro Müller"
  age  = 15
}

output "example1" {
  value = startswith(lower(local.name), "john")
}

output "example2" {
  value = abs(local.age)
}

output "example3" {
  value = yamldecode(file("${path.module}/users.yaml")).users[0]
}