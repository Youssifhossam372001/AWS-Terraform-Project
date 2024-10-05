#VPC
variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

#Internet gateway
variable "igw_id" {
  description = "The ID of the Internet Gateway"
}

#Public Subnets CIDRs
variable "pub_sub_cidrs" {
  type = list
  default = [ "10.0.0.0/24", "10.0.2.0/24" ]
}

#Private Subnets CIDRs
variable "priv_sub_cidrs" {
  type = list
  default = [ "10.0.1.0/24", "10.0.3.0/24" ]
}

#Availability Zones
variable "av_zones" {
  type = list
  default = [ "us-east-1a", "us-east-1b" ]
}