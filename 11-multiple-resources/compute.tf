locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
  }
}


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

resource "aws_instance" "from_count" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id
  # we have defined 2 subnets, which are spread over x instances
  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}

resource "aws_instance" "from_list" {
  count         = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id
  # we have defined 2 subnets, which are spread over x instances
  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}