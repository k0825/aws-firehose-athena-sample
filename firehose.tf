resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  name        = "sample_data_stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.s3.arn

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.processor.arn}:$LATEST"
        }
      }
    }

  }
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_athena_sample_firehose_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "firehose_policy" {

}

resource "aws_iam_role_policy_attachment" "firehose_policy_attachment" {

}
