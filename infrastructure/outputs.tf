output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = data.aws_ecr_repository.threat_composer.repository_url
}

