output "id" {
  value = aws_sqs_queue.project.id
}

output "arn" {
  value = aws_sqs_queue.project.arn
}

output "dlq_id" {
  value = aws_sqs_queue.dlq.id
}

output "dlq_arn" {
  value = aws_sqs_queue.dlq.arn
}
