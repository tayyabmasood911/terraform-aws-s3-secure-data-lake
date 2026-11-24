variable "aws_region" {
  type        = string
  description = "Target AWS region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. production, staging)"
  default     = "production"
}

variable "bucket_prefix" {
  type        = string
  description = "Prefix for the S3 data lake bucket name"
  default     = "prod-data-lake-"
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow bucket destruction when objects are present"
  default     = false
}

variable "enable_versioning" {
  type        = bool
  description = "Enable object versioning for data lake objects"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for server-side encryption (null uses AWS-managed key)"
  default     = null
}

variable "transition_days_ia" {
  type        = number
  description = "Number of days before transitioning objects to Standard-IA"
  default     = 30
}

variable "transition_days_glacier" {
  type        = number
  description = "Number of days before transitioning objects to Glacier Flexible"
  default     = 90
}

variable "transition_days_deep_archive" {
  type        = number
  description = "Number of days before transitioning objects to Glacier Deep Archive"
  default     = 180
}

variable "expiration_days_noncurrent" {
  type        = number
  description = "Number of days before permanently purging noncurrent object versions"
  default     = 365
}

variable "tags" {
  type        = map(string)
  description = "Additional tags applied to all created resources"
  default     = {}
}
