#Creating a DB subnet group for the RDS instance using the provided private subnet IDs

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}

#Creating an RDS instance with the specified configuration and associating it with the created security group and DB subnet group
resource "aws_db_instance" "rds" {
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  db_name                     = var.db_name
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  backup_retention_period     = var.backup_retention_period
  publicly_accessible         = var.publicly_accessible
  deletion_protection         = var.deletion_protection
  vpc_security_group_ids      = [aws_security_group.rds.id]
  db_subnet_group_name        = aws_db_subnet_group.rds.name
  parameter_group_name        = var.parameter_group_name
  skip_final_snapshot         = var.skip_final_snapshot
  storage_encrypted           = true
  username                    = var.username
  manage_master_user_password = true
  port                        = var.port
  multi_az                    = false
}

#Creating a security group for the RDS
resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id
}


#Allow inbound connections to RDS on the database port from resources using the EKS cluster security group.
resource "aws_vpc_security_group_ingress_rule" "rds" {
  security_group_id = aws_security_group.rds.id

  from_port                    = var.port
  ip_protocol                  = var.ip_protocol
  to_port                      = var.port
  referenced_security_group_id = var.cluster_security_group_id
}