module "project_queue" {
  source      = "../../aws/sqs"
  environment = var.environment
  project     = var.project
}