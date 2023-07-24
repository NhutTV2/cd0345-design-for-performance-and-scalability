terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  access_key = "ASIAW77OL5TZ36DQLVFZ"
  secret_key = "FiJg7Im8OpneDV0NfAZ48FoG9UR2BTlTvgZX2B2p"
  token = "FwoGZXIvYXdzEIj//////////wEaDBPAsDltc1n1qEbw3iLVAejqBADoTqLDdqwztSE9RH49BQIoV02hKWppLOLgWqHTOnxngFcS9lGqbPVK0sXigERtjETwS6MborU+SZRCq+OyRQa4/ue0r0dQxV47SZj5b5Aj68lbMGs7sCRkp/IZbS3T/4hV/NHssIP/OdAQcvhp7tKqMZ+DnmpoRkns6kMGMi2ES+h431VcwD4YHfEV1upNTIwfIFzIKpkIPFedHnNFRPZnmBk7Ws5HDKDzQS0KIS7n+/Y1a/zkg62TxUDCYLdAlXsiQ+FrzQQpNqCIyP61dttGlijFxPilBjItbodyAFC7gZR9K9mYH+NdVkYhNNij7ZGDiepcLkhYKOppU9GImVHmuGXb+hRg"
  region  = "us-east-1"
}

data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = var.lambda_output_path
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logs_policy" {
  name        = "lambda_logs_policy"
  path        = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_logs_policy.arn
}

resource "aws_lambda_function" "geeting_lambda" {
  function_name = var.lambda_name
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.8"
  role = aws_iam_role.lambda_exec_role.arn

  environment{
      variables = {
          greeting = "Hello World!"
      }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs_policy, aws_cloudwatch_log_group.lambda_log_group]
}

