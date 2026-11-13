output "eks_cluster_role_arn" {
  description = "The ARN of the EKS cluster role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_group_role_arn" {
  description = "The ARN of the EKS node group role"
  value       = aws_iam_role.eks_node_group_role.arn
}

output "eks_cni_role_arn" {
  description = "The ARN of the EKS CNI role"
  value       = aws_iam_role.eks_cni_role.arn
}