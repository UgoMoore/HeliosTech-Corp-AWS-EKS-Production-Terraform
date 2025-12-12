variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC id to create bastion in"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet ids (choose first for bastion)"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "ubuntu_ami_ssm_path" {
  description = "SSM parameter path for Ubuntu AMI (optional fallback). Not used when using data aws_ami."
  type        = string
  default     = "/aws/service/canonical/ubuntu/server/24/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
