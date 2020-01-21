include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  #source = "../../../../../../../python//aws-lambda/infra/modules/services/sqs_to_s3_lambda"
  source = "git::git@github.com:juttayaya/python.git//aws-lambda/infra/modules/services/sqs_to_s3_lambda?ref=v1.0.1"
}
