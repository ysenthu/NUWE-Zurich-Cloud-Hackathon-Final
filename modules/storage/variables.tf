# Define variables
variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., prod, dev, staging)"
  type        = string
}
variable "bucket_versioning" {
  description = "Bucket versioning Enabled/Disabled"
  default     = "Enabled"
  type        = string

}

variable "file_ia_days" {
  description = "Controls S3 object transition to Infrequent Access based on number of days"
  default     = 30
  type        = string

}

variable "file_glacier_days" {
  description = "Controls S3 object transition to Glacier based on number of days"
  default     = 60
  type        = number

}
