#Creating Network Load Balancer
resource "aws_lb" "network_lb" {
  name = "nlb"
  internal = false
  load_balancer_type = "network"
  subnets = [ var.public_sub1_id, var.public_sub2_id ]
  enable_deletion_protection = false
  tags = {
    name = "nlb"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name = "nlbtg"
  port = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.network_lb.arn
  port = 80
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "nlb_att1" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id = var.pub1_instance_id
  port = 80
}
resource "aws_lb_target_group_attachment" "nlb_att2" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id = var.pub2_instance_id
  port = 80
}



#Creating Application Load Balancer
resource "aws_lb" "application_lb" {
  name = "alb"
  internal = true
  load_balancer_type = "application"
  security_groups = [ var.alb_sg_id ]
  subnets = [ var.private_sub1_id, var.private_sub2_id ]
  enable_deletion_protection = false
  tags = {
    name = "alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name = "albtg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "alb_att1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = var.priv1_instance_id
  port = 80
}
resource "aws_lb_target_group_attachment" "alb_att2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = var.priv2_instance_id
  port = 80
}