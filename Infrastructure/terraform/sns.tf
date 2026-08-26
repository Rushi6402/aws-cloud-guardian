resource "aws_sns_topic" "cloud_guardian_alerts" {
  name = "aws-cloud-guardian-alerts"

  tags = {
    Project = "aws-cloud-guardian"
  }
}

resource "aws_sns_topic_subscription" "cloud_guardian_email" {
  topic_arn = aws_sns_topic.cloud_guardian_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}