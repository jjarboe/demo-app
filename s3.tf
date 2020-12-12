resource "aws_s3_bucket" "archive-storage" {
  bucket = "${var.env}-archive-files"
  versioning {
    enabled    = true
    mfa_delete = true
  }
}

resource "aws_s3_bucket_policy" "archive-storagePolicy" {
  bucket = "${aws_s3_bucket.archive-storage.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "archive-storage-restrict-access-to-users-or-roles",
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
      "Resource": "arn:aws:s3:::${aws_s3_bucket.archive-storage.id}/*"
    }
  ]
}
POLICY
}