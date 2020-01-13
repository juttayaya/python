terraform {
  required_version = "~> 0.12.19"
  required_providers {
    aws = "~> 2.31"
  }
  backend "s3" {}
  # the details of this are defined in terragrunt.hcl
}

provider "aws" {
  region = var.region
}