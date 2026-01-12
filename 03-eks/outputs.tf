output "eks_cluster_id" {
  description = "EKS Cluster ID (name)"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  description = "EKS Cluster CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

