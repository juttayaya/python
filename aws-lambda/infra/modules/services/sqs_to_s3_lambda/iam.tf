###
# IAM
###
resource "aws_iam_role" "lambda" {
  name               = local.lambda_iam_name
  description        = "Service Role for ${local.lambda_name}"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda" {
  name        = local.lambda_iam_name
  description = "IAM Policy for ${local.lambda_name}"
  policy = templatefile("${path.module}/lambda_iam_policy.tmpl",
    {
      aws_account_id = var.aws_account_id
      region         = var.region
      lambda_name    = local.lambda_name
      sqs_arn        = module.project_queue.arn
      s3_arn         = data.aws_s3_bucket.project.arn
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}