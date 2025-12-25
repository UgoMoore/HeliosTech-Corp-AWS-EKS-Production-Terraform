# 02-bastion/main.tf

module "bastion" {
  source = "../modules/bastion"

  name               = var.project
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
  instance_type      = var.instance_type
  tags               = var.tags
}

output "bastion_instance_id" {
  description = "EC2 instance ID of the bastion host"
  value       = module.bastion.bastion_instance_id
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = module.bastion.bastion_private_ip
}
