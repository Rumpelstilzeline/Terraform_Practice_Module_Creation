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
    }
  }
}


provider "aws" {
  region  = "eu-west-1"
  profile = "AdministratorAccess-565393040165"
}


