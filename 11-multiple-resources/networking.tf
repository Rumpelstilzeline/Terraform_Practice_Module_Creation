resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/18"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

resource "aws_subnet" "main" {
  count      = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}

