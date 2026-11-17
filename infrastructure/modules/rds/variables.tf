variable "private_subnet_ids" {
  description = "The IDs of the private subnets for the RDS instance"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC for the RDS instance"
  type        = string
}

variable "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster for the RDS instance"
  type        = string
}