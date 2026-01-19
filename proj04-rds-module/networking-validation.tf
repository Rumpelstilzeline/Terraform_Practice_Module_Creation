################
# Subnet Validation (shoud not be in default VPC)
###############

data "aws_vpc" "default" {          # Default-VPC jeder Region in der man deployed (zum Vergleich mit aws_subnet)
  default = true
}




data "aws_subnet" "input" {         # IDs kommen aus variables.tf
  for_each = toset(var.subnet_ids)
  id = each.value

  lifecycle {
    postcondition {
      condition = self.vpc_id != data.aws_vpc.default.id
    }
  }
}


################
# Security Group Validation
###############

