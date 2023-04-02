
resource "aws_s3_bucket" "s3" {
  bucket = "firehose_athena_sample"
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
