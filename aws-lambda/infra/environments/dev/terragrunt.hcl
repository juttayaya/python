# Common remote state
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "${local.project}-tfstate"
    region         = "us-east-1"
    key            = "environments/${local.environment}/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "${local.project}-tflock"
  }
}

locals {
  environment = "dev"
  project     = "jirawat-aws-lambda-python"
}

# Global variables
inputs = {
  environment    = local.environment
  project        = local.project
  region         = "us-east-1"
  aws_account_id = "XXXXXXXXXXX"
}
