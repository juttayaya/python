resource "aws_sqs_queue" "project" {
  name                       = var.project
  visibility_timeout_seconds = 120
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = 0
  max_message_size           = 262144
  receive_wait_time_seconds  = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 4
  })
  # kms_master_key_id                 = "alias/aws/sqs"
  # kms_data_key_reuse_period_seconds = 300

  tags = {
    Name        = var.project
    project     = var.project
    environment = var.environment
  }
}

resource "aws_sqs_queue" "dlq" {
  name                       = "${var.project}-dlq"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
  delay_seconds              = 0
  max_message_size           = 262144
  receive_wait_time_seconds  = 0
  # kms_master_key_id                 = "alias/aws/sqs"
  # kms_data_key_reuse_period_seconds = 300

  tags = {
    Name        = "${var.project}-dlq"
    project     = var.project
    environment = var.environment
  }
}