data "aws_ami" "amazon_linux_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

#Creating a Bastion Host for private instances
resource "aws_instance" "BH" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = var.public_sub1_id
  key_name = "mk-key"
  security_groups = [ var.pub_sg_id ]
  tags = {
    name = "B-Host"
  }
}

resource "aws_instance" "pub1" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = var.public_sub1_id
  key_name = "mk-key"
  security_groups = [ var.pub_sg_id ]
  provisioner "local-exec" {
    command = "echo Public IP 1 is : ${self.public_ip} >> all-ips.txt"
  }
  provisioner "file" {
    content = templatefile("./modules/ec2-instances/nginx_script.sh", {alb_dns_name = var.alb_dns_name})
    destination = "/tmp/nginx_script.sh"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/MK/mk-key.pem")
    host = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod +x /tmp/nginx_script.sh",
      "sudo /tmp/nginx_script.sh"
     ]
  }
  tags = {
    name = "Proxy 1"
  }
}

resource "aws_instance" "pub2" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = var.public_sub2_id
  key_name = "mk-key"
  security_groups = [ var.pub_sg_id ]
  provisioner "local-exec" {
    command = "echo Public IP 2 is : ${self.public_ip} >> all-ips.txt"
  }
  provisioner "file" {
    content = templatefile("./modules/ec2-instances/nginx_script.sh", {alb_dns_name = var.alb_dns_name})
    destination = "/tmp/nginx_script.sh"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/MK/mk-key.pem")
    host = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod +x /tmp/nginx_script.sh",
      "sudo /tmp/nginx_script.sh"
     ]
  }
  tags = {
    name = "Proxy 2"
  }
}


resource "aws_instance" "priv1" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = var.private_sub1_id
  key_name = "mk-key"
  security_groups = [ var.priv_sg_id ]
  provisioner "local-exec" {
    command = "echo Private IP 1 is : ${self.private_ip} >> all-ips.txt"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf update -y",
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "touch index.html",
      "echo -e 'Welcome from Web1\nBy : Mohamed khalid' > index.html ",
      "sudo mv index.html /var/www/html/index.html",
      "sudo systemctl restart httpd"
     ]
     connection {
       type = "ssh"
       user = "ec2-user"
       private_key = file("/home/MK/mk-key.pem")
       host = self.private_ip
       bastion_host = aws_instance.BH.public_ip
       bastion_private_key = file("/home/MK/mk-key.pem")
     }
  }
  tags = {
    name = "web 1"
  }
}


resource "aws_instance" "priv2" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = var.private_sub2_id
  key_name = "mk-key"
  security_groups = [ var.priv_sg_id ]
  provisioner "local-exec" {
    command = "echo Private IP 2 is : ${self.private_ip} >> all-ips.txt"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf update -y",
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "touch index.html",
      "echo -e 'Welcome from Web2\nBy : Mohamed khalid' > index.html ",
      "sudo mv index.html /var/www/html/index.html",
      "sudo systemctl restart httpd"
     ]
     connection {
       type = "ssh"
       user = "ec2-user"
       private_key = file("/home/MK/mk-key.pem")
       host = self.private_ip
       bastion_host = aws_instance.BH.public_ip
       bastion_private_key = file("/home/MK/mk-key.pem")
     }
  }
  tags = {
    name = "web 2"
  }
}
