terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.37.0"
    }
  }
}

# Actively managed by us, by our Terraform project
resource "aws_s3_bucket" "my_bucket" {
    # weiter unten definierte Variable
    bucket = var.bucket_name
}

# Managed somewhere else, we just want to use in our project
data "aws_s3_bucket" "my_external_bucket" {
    bucket = "not-managed-by-us"
}


# Sobals Variable definiert ist, kann man sie weiter oben in der Konfigruation nutzen
variable "bucket_name" {
    type = string
    description = "my variable used to set bucket name"
    default = "my_default_bucket_name"
  
}


output "bucket_id" {
    # enthält Variable, die man von weiter oben bekommt
    value = aws_s3_bucket.my_bucket.id 
}

# Hier kann man lokale Variablen (=locals) temporär speichern 
locals {
    local_example = "This is a local variable"
}


# Teil von Code, dem man ins tf-Projekt inportieren kann
module "my_module" {
    source = "./module-example"
}