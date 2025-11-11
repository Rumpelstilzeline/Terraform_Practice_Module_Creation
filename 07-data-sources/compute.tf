data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {

}

data "aws_region" "current" {

}

data "aws_vpc" "prod_vpc" {
  # über tags wird in Real-World nach passendem existierendem VPC gesucht
  tags = {
    Env = "Prod"
  }
}

data "aws_availability_zones" "available" {
  # gibt an welche AZs für einen AWS account verfügbar sind => welche AZs gibt es in der deployten Region
  state = "available"
}

data "aws_iam_policy_document" "static_website" {
  # jede Art von Ressourcen => /* können von jede Art von Principal runtergeladen (GetObject) werden
  statement {
    sid = "PublicReadGetObject"

    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = [ "s3:GetObject"]

    resources = [ "${aws_s3_bucket.public_read_bucket.arn}/*"]

  }
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "my-public-read-bucket434543"
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website
}

output "AZs" {
  # gibt Infos der AZs zurück
  value = data.aws_availability_zones.available
}

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}


resource "aws_instance" "web" {
  # ubuntu amd64 Jammy ami
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

}