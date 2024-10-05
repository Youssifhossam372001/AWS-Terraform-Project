variable "vpc_id" {}

variable "public_sub1_id" {}
variable "public_sub2_id" {}

variable "private_sub1_id" {}
variable "private_sub2_id" {}

variable "alb_sg_id" {
    type = string
}

variable "pub1_instance_id" {}
variable "pub2_instance_id" {}

variable "priv1_instance_id" {}
variable "priv2_instance_id" {}