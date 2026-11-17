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
  depends_on         = [module.vpc, module.iam]

}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids        = module.vpc.private_subnet_ids
  vpc_id                    = module.vpc.vpc_id
  cluster_security_group_id = module.eks.cluster_security_group_id
  ip_protocol               = var.ip_protocol
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  db_name                   = var.db_name
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  backup_retention_period   = var.backup_retention_period
  publicly_accessible       = var.publicly_accessible
  deletion_protection       = var.deletion_protection
  parameter_group_name      = var.parameter_group_name
  skip_final_snapshot       = var.skip_final_snapshot
  username                  = var.username
  port                      = var.port
}

