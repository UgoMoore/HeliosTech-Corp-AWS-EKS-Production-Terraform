output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value = module.vpc.private_subnets
}

# output "nat_gateway_id" {
#   description = "The NAT Gateway ID"
#   value = module.vpc.nat_gateway_id
# }

