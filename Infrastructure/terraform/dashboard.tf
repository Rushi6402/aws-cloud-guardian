resource "aws_cloudwatch_dashboard" "cloud_guardian" {
  dashboard_name = "AWS-Cloud-Guardian"

  dashboard_body = jsonencode({
    widgets = [

      # ==========================================================
      # 1. Overall Health
      # ==========================================================
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Overall Health"
          region = "us-east-1"

          view   = "singleValue"
          stat   = "Minimum"
          period = 300

          metrics = [
            [
              "AWS/CloudGuardian",
              "OverallHealth"
            ]
          ]

          yAxis = {
            left = {
              min = 0
              max = 1
            }
          }
        }
      },

      # ==========================================================
      # 2. Service Health
      # ==========================================================
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Service Health"
          region = "us-east-1"

          view   = "timeSeries"
          stat   = "Minimum"
          period = 300

          metrics = [
            [
              "AWS/CloudGuardian",
              "EC2Health",
              {
                "label" = "EC2"
              }
            ],
            [
              "AWS/CloudGuardian",
              "RDSHealth",
              {
                "label" = "RDS"
              }
            ],
            [
              "AWS/CloudGuardian",
              "LambdaHealth",
              {
                "label" = "Lambda"
              }
            ]
          ]

          yAxis = {
            left = {
              min = 0
              max = 1
            }
          }
        }
      },

      # ==========================================================
      # 3. Lambda Errors
      # ==========================================================
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Errors"
          region = "us-east-1"

          view   = "timeSeries"
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              "aws-cloud-health-monitor"
            ]
          ]
        }
      },

      # ==========================================================
      # 4. Lambda Duration
      # ==========================================================
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Duration"
          region = "us-east-1"

          view   = "timeSeries"
          stat   = "Average"
          period = 300

          metrics = [
            [
              "AWS/Lambda",
              "Duration",
              "FunctionName",
              "aws-cloud-health-monitor"
            ]
          ]
        }
      },

      # ==========================================================
      # 5. Lambda Invocations
      # ==========================================================
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Invocations"
          region = "us-east-1"

          view   = "timeSeries"
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/Lambda",
              "Invocations",
              "FunctionName",
              "aws-cloud-health-monitor"
            ]
          ]
        }
      },

      # ==========================================================
      # 6. Lambda Throttles
      # ==========================================================
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Throttles"
          region = "us-east-1"

          view   = "timeSeries"
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              "aws-cloud-health-monitor"
            ]
          ]
        }
      }
    ]
  })
}