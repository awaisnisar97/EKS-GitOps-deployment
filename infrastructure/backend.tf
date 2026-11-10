terraform {
  backend "s3" {
    bucket       = "eks-memos"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
