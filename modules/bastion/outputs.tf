output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "bastion_iam_instance_profile" {
  value = aws_iam_instance_profile.bastion_profile.name
}

output "bastion_role_name" {
  value = aws_iam_role.bastion_role.name
}
