# Input variables that the EKS module receives from the root module.
variable "cluster_role_arn" {
  description = "The ARN of the EKS cluster role"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "eks_version" {
  description = "The version of EKS to use"
  type        = string
}

variable "worker_role_arn" {
  description = "The ARN of the EKS worker node role"
  type        = string
}

variable "eks_cni_role_arn" {
  description = "The ARN of the EKS CNI role"
  type        = string
}

variable "load_balancer_controller_role_arn" {
  description = "The ARN of the EKS Load Balancer Controller role"
  type        = string
}

variable "external_dns_role_arn" {
  description = "The ARN of the EKS External DNS role"
  type        = string
}

variable "cert_manager_role_arn" {
  description = "The ARN of the EKS cert-manager role"
  type        = string
}   