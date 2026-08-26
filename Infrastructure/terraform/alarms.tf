# ============================================================
# Lambda Error Alarm
# ============================================================

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "aws-cloud-guardian-lambda-errors"
  alarm_description   = "Triggers when Cloud Guardian Lambda encounters an error"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1
  period             = 300
  metric_name        = "Errors"
  namespace          = "AWS/Lambda"
  statistic          = "Sum"
  threshold          = 0

  dimensions = {
    FunctionName = aws_lambda_function.cloud_health_monitor.function_name
  }

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]

  treat_missing_data = "notBreaching"
}


# ============================================================
# Lambda Throttles Alarm
# ============================================================

resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  alarm_name          = "aws-cloud-guardian-lambda-throttles"
  alarm_description   = "Triggers when Cloud Guardian Lambda is throttled"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1
  period             = 300
  metric_name        = "Throttles"
  namespace          = "AWS/Lambda"
  statistic          = "Sum"
  threshold          = 0

  dimensions = {
    FunctionName = aws_lambda_function.cloud_health_monitor.function_name
  }

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]

  treat_missing_data = "notBreaching"
}


# ============================================================
# Lambda Duration Alarm
# ============================================================

resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  alarm_name          = "aws-cloud-guardian-lambda-duration"
  alarm_description   = "Triggers when Cloud Guardian Lambda execution takes too long"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2
  period             = 300
  metric_name        = "Duration"
  namespace          = "AWS/Lambda"
  statistic          = "Average"
  threshold          = 5000

  dimensions = {
    FunctionName = aws_lambda_function.cloud_health_monitor.function_name
  }

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]

  treat_missing_data = "notBreaching"
}