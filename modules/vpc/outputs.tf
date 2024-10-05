output "vpc_id" {
  value = aws_vpc.vpc-1.id
}

output "igw_id" {
  value = aws_internet_gateway.internet-gw.id
}