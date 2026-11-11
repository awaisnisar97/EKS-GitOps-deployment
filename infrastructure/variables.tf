#Variables for VPC module
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "eks-memos-vpc"
}

variable "publicsubnet1_az" {
  description = "The availability zone for the first public subnet"
  type        = string
  default     = "eu-west-2a"
}

variable "publicsubnet2_az" {
  description = "The availability zone for the second public subnet"
  type        = string
  default     = "eu-west-2b"
}

variable "privatesubnet1_az" {
  description = "The availability zone for the first private subnet"
  type        = string
  default     = "eu-west-2a"
}

variable "privatesubnet2_az" {
  description = "The availability zone for the second private subnet"
  type        = string
  default     = "eu-west-2b"
}

variable "publicsubnet1_cidr" {
  description = "The CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "publicsubnet2_cidr" {
  description = "The CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "privatesubnet1_cidr" {
  description = "The CIDR block for the first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "privatesubnet2_cidr" {
  description = "The CIDR block for the second private subnet"
  type        = string
  default     = "10.0.4.0/24"
}

#Variables for