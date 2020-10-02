resource "aws_s3_bucket" "archive-storage" {
  bucket = "${var.env}-archive-files"
  versioning {
    enabled    = false
    mfa_delete = true
  }
}
