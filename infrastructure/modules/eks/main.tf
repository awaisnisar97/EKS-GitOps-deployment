resource "aws_eks_cluster" "EKS_cluster" {
  name     = "eks-cluster"
  role_arn = var.cluster_role_arn

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  version = var.eks_version

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

resource "aws_eks_node_group" "EKS_node_group" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  node_group_name = "EKS-node-group"
  node_role_arn   = var.worker_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = ["t3.medium"]

}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.EKS_cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_pod_identity_association" "vpc_cni_association" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = var.eks_cni_role_arn
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.EKS_cluster.name
  addon_name   = "eks-pod-identity-agent"
}

resource "aws_eks_addon" "core_dns" {
  cluster_name = aws_eks_cluster.EKS_cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.EKS_cluster.name
  addon_name   = "kube-proxy"
}
