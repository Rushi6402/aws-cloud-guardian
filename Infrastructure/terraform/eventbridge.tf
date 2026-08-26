resource "aws_cloudwatch_event_rule" "health_monitor_schedule" {
  name                = "aws-cloud-health-monitor-schedule"
  description         = "Runs AWS Cloud Health Monitor every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "health_monitor_lambda" {
  rule = aws_cloudwatch_event_rule.health_monitor_schedule.name

  target_id = "AWSCloudHealthMonitor"
  arn       = aws_lambda_function.cloud_health_monitor.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloud_health_monitor.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.health_monitor_schedule.arn
}