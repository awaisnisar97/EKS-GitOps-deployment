resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "rds" {
  allocated_storage       = 20
  storage_type            = "gp3"
  db_name                 = "mydb"
  engine                  = "postgres"
  engine_version          = "17"
  instance_class          = "db.t3.micro"
  backup_retention_period = 7
  publicly_accessible     = false
  deletion_protection     = false
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  parameter_group_name    = "default.postgres17"
  skip_final_snapshot     = true
}

resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "rds" {
  security_group_id = aws_security_group.rds.id

  from_port                    = var.from_port
  ip_protocol                  = var.ip_protocol
  to_port                      = var.to_port
  referenced_security_group_id = var.cluster_security_group_id
}