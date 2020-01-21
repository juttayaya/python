resource "aws_s3_bucket" "project" {
  bucket = local.s3_bucket_name
  acl    = "private"
  region = var.region

  versioning {
    enabled = false
  }
  
  tags = {
    Name        = local.s3_bucket_name
    project     = var.project
    environment = var.environment
  }
}