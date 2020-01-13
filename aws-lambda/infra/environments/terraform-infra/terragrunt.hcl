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
  environment = "terraform-infra"
  project     = "jirawat-aws-lambda-python"
}

# Global variables
inputs = {
  environment = local.environment
  region      = "us-east-1"
  project     = local.project
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = " ../../../../../../../python//aws-lambda/infra/modules/terraform-infra"
  #source = "git::git@github.com:juttayaya/python.git//aws-lambda/infra/modules/terraform-infra?ref=v1.0.0"
}
