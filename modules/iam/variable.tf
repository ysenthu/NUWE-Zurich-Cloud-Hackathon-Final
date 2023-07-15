# Define variables
variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., prod, dev, staging)"
  type        = string
}

variable "s3_bucket_arn" {
  description = "s3 bucket arn"
  type        = string

}

variable "kms_arn" {
  description = "kms key arn"
  type        = string

}
