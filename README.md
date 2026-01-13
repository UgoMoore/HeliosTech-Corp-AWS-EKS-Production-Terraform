# HeliosTech-Corp-AWS-EKS-Production-Terraform

## Project Overview
**HeliosTech-Corp-AWS-EKS-Production-Terraform** is a production-grade AWS Elastic Kubernetes Service (EKS) infrastructure deployed using **Terraform**. The project demonstrates practical DevOps, Cloud Security, and Infrastructure-as-Code (IaC) best practices, including private networking, bastion-based access, automation, and security-aware design.

**Executive Summary:** A fully automated, private AWS EKS environment built with Terraform, featuring bastion-only administrative access, modular IaC structure, and security-first networking aligned with common enterprise patterns.

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

> The **bastion host** acts as the controlled trust boundary between the public internet and private AWS resources.
Direct access to EKS worker nodes or private subnets is intentionally blocked.

---

### Why This Architecture
- Reduces attack surface by keeping EKS resources private
- Enforces controlled access through a bastion host
- Separates infrastructure layers for safer changes and teardown
- Mirrors real-world production layouts used in AWS environments

---

## Repository Structure
```
HeliosTech-Corp-AWS-EKS-Production-Terraform/
├── 01-vpc/                 # Networking layer (VPC, subnets, NAT)
├── 02-bastion/             # Bastion / jumpbox host
├── 03-eks/                 # EKS cluster & managed node groups
├── images/
├── modules/                # Reusable Terraform modules
│   ├── vpc/
│   ├── bastion/
│   └── eks/
├── scripts/                # Deployment & teardown automation
├── .env.example            # Environment variable template
├── README.md               # Project documentation
├── terraform.tfvars        # Variable values (excluded from version control)
├── provider.tf             # Configures Terraform providers and AWS authentication context
├── variables.tf            # Centralized variable definitions for consistent, reusable infrastructure configuration
└── versions.tf             # Enforces Terraform and provider version constraints to ensure build stability and reproducibility
```

---

## Security Design
- **Private EKS cluster** (no public API endpoint exposure)
- **Bastion-only access** to private resources
- IAM roles with **least privilege**
- Security groups with **restricted inbound rules**
- No hard-coded credentials (environment variables only)

**Threats Addressed:**
- Public API exposure
- Unauthorized administrative access
- Excessive IAM permissions
- Accidental credential disclosure

---

## Prerequisites
Ensure the following are installed and configured:

- Terraform >= 1.5
- AWS CLI >= v2
- kubectl
- Valid AWS account
- AWS credentials configured via environment variables or AWS CLI

```bash
aws configure
```

---

## Deployment (Step-by-Step)

### Deployment Strategy
Infrastructure is deployed in logical layers to reduce risk and simplify troubleshooting:
1. Networking (VPC)
2. Access Layer (Bastion Host)
3. Compute & Orchestration (EKS)

Each layer can be deployed or destroyed independently.

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

## Deployment & Teardown Strategy

### Deployment Order (Strict)
1. **VPC Layer** – foundational networking
2. **Bastion Host** – controlled administrative access
3. **EKS Cluster** – private Kubernetes control plane and worker nodes

### Teardown Order (Cost-Safe)
```bash
terraform -chdir=03-eks destroy -auto-approve
terraform -chdir=02-bastion destroy -auto-approve
terraform -chdir=01-vpc destroy -auto-approve
```

---

## Validation

### Verify EKS Cluster
```bash
kubectl get nodes
```

### Confirm Cluster Privacy
```bash
aws eks describe-cluster --name HeliosTech
```

---

## Deployment Evidence


### 1️⃣ Terraform Infrastructure Provisioning ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/1.%20Terraform%20apply.jpg) 
*Successful execution of Terraform apply, confirming automated provisioning of AWS infrastructure components without errors.*

### 2️⃣ VPC & Subnets Configuration ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/2.%20VPC%20flowchart.jpg) 
*Custom Virtual Private Cloud (VPC) with segmented public and private subnets, providing network isolation and controlled routing for EKS resources.

### 3️⃣ Bastion Host Instance ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/3.%20Bastion%20jump%20box.jpg) 
*Hardened bastion host deployed as a controlled entry point for administrative access into the private AWS environment.

### 4️⃣ EKS Cluster Active ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/4.%20EKS%20cluster%20created%20(ACTIVE).jpg) 
*Amazon EKS control plane successfully created and in an active state, serving as the orchestration layer for Kubernetes workloads.

### 5️⃣ Managed Node Group – Configuration & Status ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/5.1.%20EKS%20cluster%20node%20group(s).jpg) 
*AWS CLI verification confirming that a managed node group was successfully created and registered with the HeliosTech EKS control plane, indicating correct IAM role association and cluster integration.

![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/5.2.%20EKS%20cluster%20node%20group(s)%20on%20AWS%20Console.jpg) 
*EKS console view showing the managed node group in an Active state, confirming that worker nodes were successfully provisioned, joined the cluster, and are ready to run Kubernetes workloads.

### 6️⃣ kubectl Access via Bastion ![Interface Selection](https://github.com/UgoMoore/HeliosTech-Corp-AWS-EKS-Production-Terraform/blob/main/images/6.%20kubectl%20nodes%20-%20Active%20nodes.jpg) 
*Verified Kubernetes access via bastion host, confirming successful node registration and cluster connectivity using kubectl.

---

## Lessons Learned / Constraints

- EKS **managed node groups are not Free Tier eligible**
- Terraform remote state misalignment can silently break dependencies
- Outputs must exist and be populated before downstream modules consume them
- Bastion hosts remain a **critical security control** even in cloud-native designs
- Destroy validation is as important as deployment validation

---

## Skills Demonstrated
- AWS (VPC, EC2, IAM, EKS)
- Terraform (modules, state management, automation)
- Kubernetes (cluster provisioning, access control awareness)
- Cloud Networking & Security Fundamentals
- DevOps infrastructure workflows

---

## Final Project Close-Out Checklist

- [x] Infrastructure successfully deployed
- [x] Bastion access verified
- [x] EKS cluster validated
- [x] Terraform destroy executed cleanly
- [x] No active AWS resources left running
- [x] No ongoing billing risk
- [x] Documentation aligned with implementation
- [x] Repository portfolio-ready

---

## Documentation Style
This project follows a **professional SOC / DevOps documentation standard**, emphasizing:
- Clarity and traceability
- Security-first architecture
- Reproducibility
- Recruiter & ATS readability

---

## Lessons Learned & Constraints
- Private EKS clusters require careful access-path planning
- Terraform outputs are critical for multi-layer dependencies
- Bastion hosts improve security but add operational steps
- NAT Gateways introduce recurring cost considerations
- Clear documentation greatly simplifies infrastructure teardown

---

## ⚠️ Disclaimer
This repository is intended for **educational, portfolio, and demonstration purposes**, reflecting production-style patterns commonly used in cloud environments. It is not a drop-in production solution without additional monitoring, compliance, and operational controls.


