terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # mindestens Version 5.0
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
      # erzeugt random-Werte, zB Zahlen für einzigartige s3-bucket-Namen
    }
  }
}


provider "aws" {
  region  = "eu-west-1"
  profile = "AdministratorAccess-565393040165"
}


provider "aws" {
  region  = "us-east-1"
  alias   = "us-east"
  profile = "AdministratorAccess-565393040165"
}


resource "aws_s3_bucket" "my_bucket1" {
  bucket = "eu-west-1some-random-bucket-233434"
}

resource "aws_s3_bucket" "my_bucket2" {
  bucket   = "eu-west-1some-random-bucket-343423"
  provider = aws.us-east
}
