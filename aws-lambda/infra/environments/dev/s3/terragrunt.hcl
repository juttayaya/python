include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = "../../../../../../python//aws-lambda/infra/modules/aws/s3"
  #source = "git::git@github.com:juttayaya/python.git//aws-lambda/infra/modules/aws/s3?ref=v1.0.0"
}
