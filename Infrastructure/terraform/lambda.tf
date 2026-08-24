data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../../lambda/lambda_function.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "cloud_health_monitor" {
  function_name = "aws-cloud-health-monitor"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.13"
  handler = "lambda_function.lambda_handler"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  timeout = 10

  tags = {
    Project = "aws-cloud-health-monitor"
  }
}