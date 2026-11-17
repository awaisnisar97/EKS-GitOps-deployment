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

#Variables for EKS module

variable "eks_version" {
  description = "The version of EKS to use"
  type        = string
  default     = "1.37"
}

#Variables for RDS module
variable "db_name" {
  description = "The name of the database to create when the RDS instance is created"
  type        = string
  default     = "mydb"
}

variable "allocated_storage" {
  description = "The amount of storage to allocate for the RDS instance"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp3"
}

variable "engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database engine for the RDS instance"
  type        = string
  default     = "17"
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the RDS instance"
  type        = number
  default     = 7
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the RDS instance"
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with the RDS instance"
  type        = string
  default     = "default.postgres17"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance"
  type        = bool
  default     = true
}

variable "from_port" {
  description = "The starting port for the security group rule"
  type        = number
  default     = 5432
}

variable "to_port" {
  description = "The ending port for the security group rule"
  type        = number
  default     = 5432
}

variable "ip_protocol" {
  description = "The IP protocol for the security group rule"
  type        = string
  default     = "tcp"
}



