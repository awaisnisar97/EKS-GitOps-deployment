module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  publicsubnet1_cidr  = var.publicsubnet1_cidr
  publicsubnet1_az    = var.publicsubnet1_az
  publicsubnet2_cidr  = var.publicsubnet2_cidr
  publicsubnet2_az    = var.publicsubnet2_az
  privatesubnet1_cidr = var.privatesubnet1_cidr
  privatesubnet1_az   = var.privatesubnet1_az
  privatesubnet2_cidr = var.privatesubnet2_cidr
  privatesubnet2_az   = var.privatesubnet2_az
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source = "./modules/eks"

  cluster_role_arn   = module.iam.eks_cluster_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_version        = var.eks_version
  worker_role_arn    = module.iam.eks_node_group_role_arn
  eks_cni_role_arn   = module.iam.eks_cni_role_arn
     depends_on = [module.vpc, module.iam]
  
}