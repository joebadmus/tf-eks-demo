provider "aws" {
  region = "eu-west-2"
}

#Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name   = var.vpc_name
    Author = var.author
    Tool   = var.tool
  }
}

#Create internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "main_igw"
  }
}


# Create Network access list for vpc
resource "aws_network_acl" "allowall" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "my_nacl"
  }
}

# Create Network security for vpc
resource "aws_security_group" "allowall" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "security-group"

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

}
