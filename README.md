# AWS Cloud Guardian

> Automated AWS Infrastructure Health Monitoring, Observability, and Alerting System

AWS Cloud Guardian is a serverless AWS monitoring project that automatically checks the health of AWS resources and provides centralized observability through Amazon CloudWatch.

The system performs scheduled health checks using AWS Lambda, publishes custom health metrics to CloudWatch, visualizes the metrics through a CloudWatch dashboard, evaluates CloudWatch alarms, and sends email notifications through Amazon SNS when an alarm is triggered.

The infrastructure is provisioned and managed using Terraform, while GitHub Actions is used for Lambda CI/CD deployment.

---

# 📌 Project Overview

AWS Cloud Guardian is designed to provide a simple automated health-monitoring solution for AWS infrastructure.

The system currently monitors:

- Amazon EC2
- Amazon RDS
- AWS Lambda

The health-check process runs automatically every **5 minutes** using Amazon EventBridge.

The Lambda function collects the health information and publishes custom CloudWatch metrics.

CloudWatch then provides:

- Metrics
- Dashboard
- Logs
- Alarms
- Notifications

When an alarm enters the `ALARM` state, Amazon SNS sends an email notification.

---

# 🎯 Project Objective

The main objective of AWS Cloud Guardian is to build a lightweight cloud monitoring system that can:

1. Automatically check AWS resource health.
2. Detect unhealthy conditions.
3. Publish health metrics.
4. Visualize infrastructure health.
5. Generate CloudWatch alarms.
6. Send email alerts.
7. Deploy Lambda code automatically using CI/CD.
8. Manage infrastructure using Terraform.

---

# 🏗️ Architecture

```text
                              GitHub
                                |
                                |
                           Git Push
                                |
                                v
                     +----------------------+
                     |    GitHub Actions     |
                     |       CI/CD          |
                     +----------+-----------+
                                |
                                |
                         Deploy Lambda
                                |
                                v
                    +-----------------------+
                    |   AWS Lambda          |
                    | aws-cloud-health-     |
                    | monitor               |
                    +----------+------------+
                               |
              +----------------+----------------+
              |                |                |
              v                v                v
        +-----------+    +-----------+    +-----------+
        |    EC2    |    |    RDS    |    |  Lambda   |
        | Health    |    | Health    |    |  Health   |
        | Check     |    | Check     |    | Check    |
        +-----------+    +-----------+    +-----------+
              |                |                |
              +----------------+----------------+
                               |
                               v
                    +-----------------------+
                    |   CloudWatch Metrics  |
                    |                       |
                    | AWS/CloudGuardian     |
                    +-----------+-----------+
                                |
                 +--------------+--------------+
                 |              |              |
                 v              v              v
             Dashboard       Alarms           Logs
                 |              |
                 |              v
                 |             SNS
                 |              |
                 |              v
                 |          Email Alert
                 |
                 v
          AWS-Cloud-Guardian
             Dashboard


                    EventBridge
                        |
                        | Every 5 minutes
                        |
                        v
              AWS Health Monitor Lambda






## 📊 CloudWatch Dashboard

![AWS Cloud Guardian Dashboard](screenshots/cloudwatch-dashboard.png)

## 🚨 CloudWatch Alarms

![CloudWatch Alarms](screenshots/cloudwatch-alarms.png)

## ⚡ Lambda Health Monitor

![Lambda](screenshots/lambda.png)

## ⏰ EventBridge Schedule

![EventBridge](screenshots/eventbridge.png)