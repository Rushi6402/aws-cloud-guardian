resource "aws_cloudwatch_dashboard" "cloud_guardian" {
  dashboard_name = "AWS-Cloud-Guardian"

  dashboard_body = jsonencode({
    widgets = [

      # ---------------------------------------------------------
      # Lambda Invocations
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Lambda Invocations"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          stat = "Sum"

          metrics = [
            [
              "AWS/Lambda",
              "Invocations",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name
            ]
          ]

          yAxis = {
            left = {
              label = "Invocations"
              min   = 0
            }
          }
        }
      },

      # ---------------------------------------------------------
      # Lambda Errors
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Lambda Errors"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          stat = "Sum"

          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name
            ]
          ]

          yAxis = {
            left = {
              label = "Errors"
              min   = 0
            }
          }
        }
      },

      # ---------------------------------------------------------
      # Lambda Duration
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Lambda Duration"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          stat = "Average"

          metrics = [
            [
              "AWS/Lambda",
              "Duration",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name
            ]
          ]

          yAxis = {
            left = {
              label = "Milliseconds"
              min   = 0
            }
          }
        }
      },

      # ---------------------------------------------------------
      # Lambda Throttles
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Lambda Throttles"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          stat = "Sum"

          metrics = [
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name
            ]
          ]

          yAxis = {
            left = {
              label = "Throttles"
              min   = 0
            }
          }
        }
      },

      # ---------------------------------------------------------
      # Lambda Concurrent Executions
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Concurrent Executions"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          stat = "Maximum"

          metrics = [
            [
              "AWS/Lambda",
              "ConcurrentExecutions",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name
            ]
          ]

          yAxis = {
            left = {
              label = "Executions"
              min   = 0
            }
          }
        }
      },

      # ---------------------------------------------------------
      # Lambda Invocations vs Errors
      # ---------------------------------------------------------
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6

        properties = {
          title = "Cloud Guardian - Invocations vs Errors"

          view   = "timeSeries"
          region = var.aws_region

          period = 300

          metrics = [
            [
              "AWS/Lambda",
              "Invocations",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name,
              {
                label = "Invocations"
                stat  = "Sum"
              }
            ],
            [
              ".",
              "Errors",
              "FunctionName",
              aws_lambda_function.cloud_health_monitor.function_name,
              {
                label = "Errors"
                stat  = "Sum"
              }
            ]
          ]
        }
      },

      # ---------------------------------------------------------
      # Lambda Health Summary
      # ---------------------------------------------------------
      {
        type   = "text"
        x      = 0
        y      = 18
        width  = 24
        height = 5

        properties = {
          markdown = <<-EOT
            # 🛡️ AWS Cloud Guardian

            **Monitoring Region:** `${var.aws_region}`

            **Monitored Resources**

            | Resource | Status |
            |---|---|
            | EC2 | 🔍 Health checked by Lambda |
            | RDS | 🔍 Health checked by Lambda |
            | Lambda | 🔍 Health checked by Lambda |
            | EventBridge | ⏱️ Runs every 5 minutes |
            | SNS | 📧 Sends unhealthy alerts |

            **Lambda:** `${aws_lambda_function.cloud_health_monitor.function_name}`

            **Project:** AWS Cloud Guardian
          EOT
        }
      }
    ]
  })
}