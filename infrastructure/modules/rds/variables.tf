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

variable "allocated_storage" {
  description = "The allocated storage in gigabytes for the RDS instance"
  type        = number
}

variable "storage_type" {
  description = "The storage type for the RDS instance (e.g., gp2, io1, standard)"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create when the RDS instance is created"
  type        = string
}

variable "engine" {
  description = "The database engine to use for the RDS instance (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine to use for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance class to use for the RDS instance (e.g., db.t2.micro, db.t3.medium)"
  type        = string
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the RDS instance"
  type        = number
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the RDS instance"
  type        = bool
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with the RDS instance"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance"
  type        = bool
}


variable "ip_protocol" {
  description = "The protocol for the RDS instance"
  type        = string
}

variable "username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "port" {
  description = "The port for the RDS instance"
  type        = number
}


