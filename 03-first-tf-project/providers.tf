terraform {
    required_version = ">= 1.7.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        # mindestens Version 5.0
        version = "~> 5.0"  
      }
      random = {
        source = "hashicorp/random"
        version = "~> 3.0"
      }

    }
}


provider "aws" {
    region = "eu-west-1" 
}


# stellt sicher, dass es eine random-ID am Ende des Bucket-Names gibt
resource "random_id" "bucket_sufix" {
    byte_length = 6
}

resource "aws_s3_bucket" "example_bucket" {
    bucket = "example-bucket-${random_id.bucket_sufix.hex}" 
}

output "bucket_name" {
    value = aws_s3_bucket.example_bucket.bucket
}