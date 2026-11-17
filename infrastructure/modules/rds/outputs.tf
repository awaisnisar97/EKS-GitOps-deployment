output "address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds.address
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.rds.id
}

output "master_user_secret" {
  description = "The ARN of the secret containing the master user password"
  value       = aws_db_instance.rds.master_user_secret[0].secret_arn
}
