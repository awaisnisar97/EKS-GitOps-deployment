

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = var.cluster_role_arn

  depends_on = [aws_cloudwatch_log_group.eks_cluster_log_group]
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

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
  cluster_name    = aws_eks_cluster.eks_cluster.name
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
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}


resource "aws_eks_pod_identity_association" "vpc_cni_association" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = var.eks_cni_role_arn
}


resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "eks-pod-identity-agent"
}


resource "aws_eks_addon" "core_dns" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
}


resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}


resource "aws_eks_pod_identity_association" "load_balancer_controller_association" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = var.load_balancer_controller_role_arn
}


resource "aws_eks_pod_identity_association" "external_dns_association" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "external-dns"
  role_arn        = var.external_dns_role_arn
}

resource "aws_eks_pod_identity_association" "cert_manager_association" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "cert-manager"
  service_account = "cert-manager"
  role_arn        = var.cert_manager_role_arn
}

resource "aws_cloudwatch_log_group" "eks_cluster_log_group" {
  name              = "/aws/eks/eks-cluster/cluster"
  retention_in_days = 5
}