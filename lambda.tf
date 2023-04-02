resource "aws_lambda_function" "processor" {
  filename         = "./build/lambda_function_payload.zip"
  function_name    = "firehose_processor"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_handler"
  source_code_hash = data.archive_file.processor.output_base64sha256
  runtime          = "python3.8"
}

data "archive_file" "processor" {
  type        = "zip"
  source_file = "./src/handler.py"
  output_path = "./build/lambda_function_payload.zip"
}


resource "aws_iam_role" "lambda_role" {
  name = "firehose_athena_sample_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
