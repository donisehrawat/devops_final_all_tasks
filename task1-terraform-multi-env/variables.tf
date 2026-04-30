variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name: dev, staging, or prod"
  type        = string
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "myapp"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "bucket_suffix" {
  description = "Unique suffix for S3 bucket"
  type        = string
}
