#Tells Terraform to use the S3 backend for storing the state file. The state file is stored in an S3 bucket named "eks-memos"
terraform {
  backend "s3" {
    bucket       = "eks-memos"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
