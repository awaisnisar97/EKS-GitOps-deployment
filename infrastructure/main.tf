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


