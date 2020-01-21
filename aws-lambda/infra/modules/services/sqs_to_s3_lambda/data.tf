data "aws_s3_bucket" "project" {
  bucket = "${var.project}-${var.environment}-${var.region}"
}

###
# Package lambda zip locally
###
data "archive_file" "zip_lambda_locally" {
  type        = "zip"
  output_path = "${local.lambda_zip_dir}/${local.lambda_name}.zip"

  source {
    content  = file("${path.module}/lambda_function.py")
    filename = "lambda_function.py"
  }
}
