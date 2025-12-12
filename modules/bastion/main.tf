# modules/bastion/main.tf
# Bastion host placed in a private subnet, SSM-managed (no public IP).

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# IAM role for the bastion (SSM + minimal extra permissions)
data "aws_iam_policy_document" "bastion_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "bastion_role" {
  name               = "${var.name}-bastion-role"
  assume_role_policy = data.aws_iam_policy_document.bastion_assume.json
  tags               = var.tags
}

# Attach managed policies: SSM and CloudWatch (logs)
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cw_agent" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Minimal inline policy to allow reading EKS cluster (for kubeconfig)
resource "aws_iam_role_policy" "eks_describe" {
  name = "${var.name}-bastion-eks-describe"
  role = aws_iam_role.bastion_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.name}-bastion-profile"
  role = aws_iam_role.bastion_role.name
}

# Security Group: No inbound from Internet; allow necessary internal flows if needed
resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}-bastion-sg"
  description = "Bastion SG - private instance (no public SSH). SSM agent uses outbound HTTPS."
  vpc_id      = var.vpc_id

  # No inbound rules from the internet. You can allow inbound from internal CIDRs if desired.
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [] # intentionally empty
    ipv6_cidr_blocks = []
    description = "No public inbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# EC2 instance in a private subnet, no public IP, SSM will manage it
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  tags                        = merge(var.tags, { Name = "${var.name}-bastion" })

  # Install utilities so the bastion can run automation (awscli, kubectl, helm)
  user_data = <<-EOF
              #!/usr/bin/env bash
              set -euo pipefail
              apt-get update -y && apt-get install -y curl unzip jq apt-transport-https gnupg

              # Install AWS CLI v2 if missing
              if ! command -v aws >/dev/null 2>&1; then
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
                unzip /tmp/awscliv2.zip -d /tmp
                /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin
                rm -rf /tmp/awscliv2.zip /tmp/aws
              fi

              # Install kubectl
              if ! command -v kubectl >/dev/null 2>&1; then
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || true
                rm -f kubectl
              fi

              # Install Helm
              if ! command -v helm >/dev/null 2>&1; then
                curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
              fi

              # Ensure ubuntu user has .kube dir
              mkdir -p /home/ubuntu/.kube
              chown -R ubuntu:ubuntu /home/ubuntu/.kube

              # Start and enable SSM agent (some AMIs already have it)
              if systemctl list-unit-files | grep -q amazon-ssm-agent; then
                systemctl enable amazon-ssm-agent || true
                systemctl start amazon-ssm-agent || true
              fi

              EOF
}
