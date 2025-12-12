variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "key_name" {
  type = string
  description = "Name of the AWS key pair for SSH access (optional if using SSM)"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Optional public subnets for bastion if needed (SSM-managed is default)"
  default = []
}
