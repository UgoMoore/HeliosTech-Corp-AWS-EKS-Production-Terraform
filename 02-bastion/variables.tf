variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags applied to bastion resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "HeliosTech"
  }
}
