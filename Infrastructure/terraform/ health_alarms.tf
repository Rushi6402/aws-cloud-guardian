# ============================================================
# AWS Cloud Guardian - Health Alarms
# ============================================================

# ------------------------------------------------------------
# EC2 Health Alarm
# ------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "ec2_unhealthy" {
  alarm_name        = "aws-cloud-guardian-ec2-unhealthy"
  alarm_description = "Triggers when EC2 health check reports unhealthy"

  namespace   = "AWS/CloudGuardian"
  metric_name = "EC2Health"

  statistic = "Minimum"
  period    = 300

  evaluation_periods  = 1
  datapoints_to_alarm = 1

  comparison_operator = "LessThanThreshold"
  threshold           = 1

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]
}


# ------------------------------------------------------------
# RDS Health Alarm
# ------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "rds_unhealthy" {
  alarm_name        = "aws-cloud-guardian-rds-unhealthy"
  alarm_description = "Triggers when RDS health check reports unhealthy"

  namespace   = "AWS/CloudGuardian"
  metric_name = "RDSHealth"

  statistic = "Minimum"
  period    = 300

  evaluation_periods  = 1
  datapoints_to_alarm = 1

  comparison_operator = "LessThanThreshold"
  threshold           = 1

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]
}


# ------------------------------------------------------------
# Lambda Health Alarm
# ------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "lambda_unhealthy" {
  alarm_name        = "aws-cloud-guardian-lambda-unhealthy"
  alarm_description = "Triggers when Lambda health check reports unhealthy"

  namespace   = "AWS/CloudGuardian"
  metric_name = "LambdaHealth"

  statistic = "Minimum"
  period    = 300

  evaluation_periods  = 1
  datapoints_to_alarm = 1

  comparison_operator = "LessThanThreshold"
  threshold           = 1

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]
}


# ------------------------------------------------------------
# Overall Health Alarm
# ------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "overall_unhealthy" {
  alarm_name        = "aws-cloud-guardian-overall-unhealthy"
  alarm_description = "Triggers when overall Cloud Guardian health is unhealthy"

  namespace   = "AWS/CloudGuardian"
  metric_name = "OverallHealth"

  statistic = "Minimum"
  period    = 300

  evaluation_periods  = 1
  datapoints_to_alarm = 1

  comparison_operator = "LessThanThreshold"
  threshold           = 1

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.cloud_guardian_alerts.arn
  ]
}