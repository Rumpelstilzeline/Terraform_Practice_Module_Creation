terraform {
  required_version = ">= 1.7.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "AdministratorAccess-565393040165"
}

provider "aws" {
  region  = "us-east-1"
  profile = "AdministratorAccess-565393040165"
  alias   = "us-east"
}