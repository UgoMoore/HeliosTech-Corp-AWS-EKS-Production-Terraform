# 02-bastion/terraform.tfvars

# Name of your project
project = "HeliosTech"

# VPC ID from 01-vpc output
vpc_id = "vpc-0abcd1234ef567890"

# Private subnets (from 01-vpc output)
private_subnet_ids = [
  "subnet-0a1b2c3d4e5f6g7h8",
  "subnet-1h2g3f4e5d6c7b8a9"
]

# Public subnets (for NAT or optional use, if your bastion module requires it)
public_subnet_ids = [
  "subnet-0123456789abcdef0",
  "subnet-0fedcba9876543210"
]

# EC2 instance type for bastion host
instance_type = "t3.micro"

# Key pair for SSH access
key_name = "my-aws-key"

# Tags applied to all resources
tags = {
  Environment = "dev"
  Project     = "HeliosTech"
}
