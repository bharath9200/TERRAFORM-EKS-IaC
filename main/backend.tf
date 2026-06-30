terraform {
  backend "s3" {
    bucket       = "devfolio-infra-project-bharath-1"
    key          = "module/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = "true"
  }
}