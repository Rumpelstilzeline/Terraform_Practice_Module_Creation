terraform {
  required_providers {
    aws = { 
        source = "hashicorp/aws"
        version = "~> 5.0"

    }
  }
}

provider "aws" {
    region = "eu-west-1" 
    # profile muss dazu, wenn man aws sso als Authentifizierungsmethode nutzt
    profile = "AdministratorAccess-565393040165" 
}

# Deklarieren eines VPCs
resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        # Name angegeben, dass man die Änderungen besser in der UI von AWS sehen kann
        Name = "Terraform VPC"
    } 
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.0.0/24"  
    # wird mit unserem vpc verbunden
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.1.0/24" 
    # wird mit unserem vpc verbunden 
}

resource "aws_internet_gateway" "igw" {
    vpc_id =  aws_vpc.demo_vpc .id
    # igw wird mit vpc verbunden
}

# Verbinden des igw mit einem Route Table bzw. Nutzung im Route Table in unserem VPC

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.demo_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    } 
}

resource "aws_route_table_association" "public_subnet" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rtb.id
}