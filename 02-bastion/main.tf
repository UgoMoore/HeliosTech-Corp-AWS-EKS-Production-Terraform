# 02-bastion/main.tf
module "bastion" {
  source = "../modules/bastion"

  name               = var.project
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  instance_type      = var.instance_type
  tags               = var.tags
}

output "bastion_instance_id" {
  value = module.bastion.bastion_instance_id
}

output "bastion_private_ip" {
  value = module.bastion.bastion_private_ip
}
