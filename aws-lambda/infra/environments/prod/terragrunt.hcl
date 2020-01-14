# Common remote state
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "${local.project}-tfstate"
    region         = "us-east-1"
    key            = "environments/${local.environment}/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "jirawat-python-tflock"
  }
}

locals {
  environment = "prod"
  project     = "jirawat-aws-lambda-python"
}

# Global variables
inputs = {
  environment = local.environment
  project     = local.project
  region      = "us-west-1"
}
