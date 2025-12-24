# HeliosTech-Corp-AWS-EKS-Production-Terraform

## Project Overview
**HeliosTech-Corp-AWS-EKS-Production-Terraform** is a production-grade AWS Elastic Kubernetes Service (EKS) infrastructure deployed using **Terraform**. The project demonstrates real-world DevOps, Cloud Security, and Infrastructure-as-Code (IaC) best practices, including private networking, bastion-based access, automation, and security hardening.

This repository is designed as a **portfolio-ready, recruiter-friendly project**, showcasing hands-on experience with AWS, Kubernetes, Terraform modules, and production architecture design.

---

## Project Objectives
- Provision a **secure, production-ready AWS EKS cluster** using Terraform
- Enforce **network isolation** using private subnets
- Enable secure access via a **bastion (jumpbox) host**
- Apply **IaC best practices** (modular design, reusability, automation)
- Demonstrate **cloud security and DevOps competency** suitable for enterprise environments

---

## Architecture Overview

**Core Components:**
- AWS VPC (custom networking)
- Public and Private Subnets
- Internet Gateway & NAT Gateway
- Bastion Host (Jumpbox)
- Amazon EKS Cluster
- IAM Roles & Policies
- Security Groups (least-privilege access)

**High-Level Flow:**
```
User → Bastion Host → Private EKS Cluster → Worker Nodes
```

---

## Repository Structure
```
HeliosTech-Corp-AWS-EKS-Production-Terraform/
├── 01-vpc/                 # Networking layer (VPC, subnets, NAT)
├── 02-bastion/             # Bastion / jumpbox host
├── 03-eks/                 # EKS cluster & node groups
├── modules/                # Reusable Terraform modules
│   ├── vpc/
│   ├── bastion/
│   └── eks/
├── scripts/                # Automation & helper scripts
├── .env.example            # Environment variable template
├── README.md               # Project documentation
└── terraform.tfvars        # Variable values (excluded from version control)
```

---

## Security Design
- **Private EKS cluster** (no public API endpoint exposure)
- **Bastion-only access** to private resources
- IAM roles with **least privilege**
- Security groups with **restricted inbound rules**
- No hard-coded credentials (environment variables only)

---

## Prerequisites
Ensure the following are installed and configured:
- Terraform >= 1.5
- AWS CLI >= v2
- kubectl
- Valid AWS account
- AWS credentials configured via environment variables

```bash
aws configure
```

---

## Deployment (Step-by-Step)

### Step 1: Clone Repository
```bash
git clone https://github.com/<your-username>/HeliosTech-Corp-AWS-EKS-Production-Terraform.git
cd HeliosTech-Corp-AWS-EKS-Production-Terraform
```

---

### Step 2: Deploy VPC Layer
```bash
terraform -chdir=01-vpc init
terraform -chdir=01-vpc plan
terraform -chdir=01-vpc apply -auto-approve
```

---

### Step 3: Deploy Bastion Host
```bash
terraform -chdir=02-bastion init
terraform -chdir=02-bastion plan
terraform -chdir=02-bastion apply -auto-approve
```

---

### Step 4: Deploy EKS Cluster
```bash
terraform -chdir=03-eks init
terraform -chdir=03-eks plan
terraform -chdir=03-eks apply -auto-approve
```

---

## Validation
- Verify EKS cluster:
```bash
kubectl get nodes
```

- Confirm private networking:
```bash
aws eks describe-cluster --name heliostech-eks
```

---

## Teardown (Destroy Resources)
To avoid unnecessary AWS costs:
```bash
terraform -chdir=03-eks destroy -auto-approve
terraform -chdir=02-bastion destroy -auto-approve
terraform -chdir=01-vpc destroy -auto-approve
```

---

## Skills Demonstrated
- AWS (VPC, EC2, IAM, EKS)
- Terraform (modules, state management, automation)
- Kubernetes (cluster provisioning, security awareness)
- Cloud Security & Networking
- DevOps best practices
- Infrastructure automation

---

## Documentation Style
This project follows a **professional SOC / DevOps documentation style**, emphasizing:
- Clarity
- Reproducibility
- Security-first design
- Recruiter & ATS readability

---

## 📌 Notes
This repository is intended for **educational, portfolio, and demonstration purposes**, reflecting real-world production patterns used in enterprise cloud environments.

---

