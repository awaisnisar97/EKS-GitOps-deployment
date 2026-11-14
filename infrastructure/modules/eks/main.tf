resource "aws_eks_cluster" "EKS_cluster" {
  name     = "EKS-cluster"
  role_arn = var.cluster_role_arn

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  version  = var.eks_version
    
  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

resource "aws_eks_node_group" "EKS_node_group" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  node_group_name = "EKS-node-group"
  node_role_arn   = module.iam.eks_node_group_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = ["t3.medium"]

}

