locals {
  lambda_name     = "sqs_to_s3_lambda"
  lambda_zip_dir  = "/tmp"
  lambda_iam_name = "${local.lambda_name}_${var.environment}_${var.region}"
}