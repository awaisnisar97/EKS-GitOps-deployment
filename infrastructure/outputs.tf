#RDS

output "master_user_secret" {
  description = "The ARN of the secret containing the master user password"
  value       = module.rds.master_user_secret
}
