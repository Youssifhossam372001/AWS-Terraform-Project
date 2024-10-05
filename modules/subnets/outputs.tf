output "public_sub1_id" {
  value = aws_subnet.pub_sub1.id
}

output "public_sub2_id" {
  value = aws_subnet.pub_sub2.id
}

output "private_sub1_id" {
  value = aws_subnet.priv_sub1.id
}

output "private_sub2_id" {
  value = aws_subnet.priv_sub2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}