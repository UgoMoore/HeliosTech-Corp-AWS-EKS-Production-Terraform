<<<<<<< HEAD
## heliostech-aws-eks-production

This repository contains project files, scripts, and labs related to heliostech-aws-eks-production.


=======
# Heliostech-AWS-EKS-production
>>>>>>> 54dd5ab40d7d70b31cc7a24dea1b233651f7487d

### Project layout

css
Heliostech-Corp/
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── bastion/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── bastion-iam-policy.json
│   └── addons/
│       └── helm-addons.tf
│
├── 01-vpc/
│   └── main.tf
├── 02-eks/
│   └── main.tf
├── scripts/
│   ├── remote_install_addons.sh
│   └── kubeconfig_export.sh
├── versions.tf
├── provider.tf
├── variables.tf
├── .env
└── README.md

