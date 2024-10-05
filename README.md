# AWS Terraform Project

This project uses Terraform to create and manage AWS infrastructure components, providing a scalable, secure, and highly available environment.

## Infrastructure Overview

The following resources are provisioned:

- **VPC (Virtual Private Cloud)**: 
  - A custom VPC with CIDR block setup
  - Public and private subnets for segregation
  - Internet Gateway (IGW) for internet access in public subnets
  - NAT Gateway for internet access in private subnets

- **EC2 Instances**:
  - EC2 instances are provisioned in public/private subnets based on configuration.
  - Auto-scaling and Load Balancing are set up (optional).

- **S3 Buckets**:
  - S3 bucket for storing static assets or backups.
  - Configured with versioning and access control for data protection.

- **Security Groups**:
  - Custom security groups to control access to instances.
