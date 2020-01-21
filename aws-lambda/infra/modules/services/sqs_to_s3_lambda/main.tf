module "project_queue" {
  source      = "../../aws/sqs"
  environment = var.environment
  project     = var.project
}

###
# Lambda
###
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = 14
}

resource "aws_lambda_function" "sqs_to_s3" {
  function_name    = local.lambda_name
  filename         = "${local.lambda_zip_dir}/${local.lambda_name}.zip"
  source_code_hash = data.archive_file.zip_lambda_locally.output_base64sha256
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {
      s3_bucket_output = data.aws_s3_bucket.project.id
    }
  }

  timeouts {
    create = "5m"
  }

  lifecycle {
    ignore_changes = [last_modified]
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda,
    aws_cloudwatch_log_group.lambda
  ]

  tags = {
    Name        = local.lambda_name
    project     = var.project
    environment = var.environment
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_s3" {
  event_source_arn = module.project_queue.arn
  function_name    = aws_lambda_function.sqs_to_s3.arn
}