#Creating Public Subnets
resource "aws_subnet" "pub_sub1" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_sub_cidrs[0]
  availability_zone = var.av_zones[0]
  map_public_ip_on_launch = true
  tags = {
    name = "public-subnet-1"
  }
}
resource "aws_subnet" "pub_sub2" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_sub_cidrs[1]
  availability_zone = var.av_zones[1]
  map_public_ip_on_launch = true
  tags = {
    name = "public-subnet-2"
  }
}

#Creating route table for public subnets
resource "aws_route_table" "pub_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    name = "Pub-routeT"
  }
}

#Associate the public route table to subnets
resource "aws_route_table_association" "a_pub1" {
  route_table_id = aws_route_table.pub_rt.id
  subnet_id = aws_subnet.pub_sub1.id
}
resource "aws_route_table_association" "a_pub2" {
  route_table_id = aws_route_table.pub_rt.id
  subnet_id = aws_subnet.pub_sub2.id
}


#Creating Private Subnets
resource "aws_subnet" "priv_sub1" {
  vpc_id = var.vpc_id
  cidr_block = var.priv_sub_cidrs[0]
  availability_zone = var.av_zones[0]
  tags = {
    name = "private-subnet-1"
  }
}
resource "aws_subnet" "priv_sub2" {
  vpc_id = var.vpc_id
  cidr_block = var.priv_sub_cidrs[1]
  availability_zone = var.av_zones[1]
  tags = {
    name = "private-subnet-2"
  }
}

#Craeting NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.pub_sub1.id
}

#Creating route table for private subnets
resource "aws_route_table" "priv_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    name = "Priv-routeT"
  }
}

#Associate the private route table to subnets
resource "aws_route_table_association" "a_priv1" {
  route_table_id = aws_route_table.priv_rt.id
  subnet_id = aws_subnet.priv_sub1.id
}
resource "aws_route_table_association" "a_priv2" {
  route_table_id = aws_route_table.priv_rt.id
  subnet_id = aws_subnet.priv_sub2.id
}
