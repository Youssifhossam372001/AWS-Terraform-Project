#Creating the VPC
resource "aws_vpc" "vpc-1" {
  cidr_block = var.cidr_vpc
  tags = {
    name = var.vpc_name
  }
}

#Creating Internet Gateway
resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    name = "igw"
  }
}
