variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-cloud-guardian"
}

variable "alert_email" {
  description = "rushipatil8582@gmail.com"
  type        = string
  sensitive   = true
}