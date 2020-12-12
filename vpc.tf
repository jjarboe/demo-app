resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_flow_log" "main_vpc" {
  vpc_id          = "${aws_vpc.main_vpc.id}"
  iam_role_arn    = "##arn:aws:iam::111111111111:role/sample_role##"
  log_destination = "${aws_s3_bucket.main_vpc.arn}"
  traffic_type    = "ALL"

  tags = {
    GeneratedBy      = "Accurics"
    ParentResourceId = "aws_vpc.main_vpc"
  }
}
resource "aws_s3_bucket" "main_vpc" {
  bucket        = "main_vpc_flow_log_s3_bucket"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled    = true
    mfa_delete = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
resource "aws_s3_bucket_policy" "main_vpc" {
  bucket = "${aws_s3_bucket.main_vpc.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "main_vpc-restrict-access-to-users-or-roles",
      "Effect": "Allow",
      "Principal": [
        {
          "AWS": [
            "arn:aws:iam::##acount_id##:role/##role_name##",
            "arn:aws:iam::##acount_id##:user/##user_name##"
          ]
        }
      ],
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.main_vpc.id}/*"
    }
  ]
}
POLICY
}