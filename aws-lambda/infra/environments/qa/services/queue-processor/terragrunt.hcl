include {
  path = find_in_parent_folders()
}

terraform {
  # Uncomment to use local filesystem terraform modules
  source = "../../../../../../../python//aws-lambda/infra/modules/services/queue-processor"
  #source = "git::git@github.com:juttayaya/python.git//aws-lambda/infra/modules/vpc/vpc-networking?ref=v1.0.0"
}
