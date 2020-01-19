resource "aws_s3_bucket" "project" {
  bucket = var.project
  acl    = "private"
  region = var.region

  versioning {
    enabled = false
  }
  
  tags = {
    Name        = var.project
    project     = var.project
    environment = var.environment
  }
}