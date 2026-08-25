resource "aws_iam_role" "lambda_role" {
  name = "aws-cloud-health-monitor-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Cloud Guardian read-only permissions
resource "aws_iam_role_policy" "cloud_guardian_read_only" {
  name = "CloudGuardianReadOnly"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "lambda:ListFunctions",
          "lambda:GetFunction"
        ]

        Resource = "*"
      }
    ]
  })
}