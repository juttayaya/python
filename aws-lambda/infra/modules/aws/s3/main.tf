resource "aws_s3_bucket" "project" {
  bucket = "${var.project}-${var.region}"
  acl    = "private"
  region = var.region

  versioning {
    enabled = false
  }
  
  tags = {
    Name        = "${var.project}-${var.region}"
    project     = var.project
    environment = var.environment
  }
}