output "pub1_instance_id" {
  value = aws_instance.pub1.id
}

output "pub2_instance_id" {
  value = aws_instance.pub2.id
}

output "priv1_instance_id" {
  value = aws_instance.priv1.id
}

output "priv2_instance_id" {
  value = aws_instance.priv2.id
}

output "pub1_ip" {
  value = aws_instance.pub1.public_ip
}

output "pub2_ip" {
  value = aws_instance.pub2
}

output "priv1_ip" {
  value = aws_instance.priv1.private_ip
}

output "priv2_ip" {
  value = aws_instance.priv2.private_ip
}