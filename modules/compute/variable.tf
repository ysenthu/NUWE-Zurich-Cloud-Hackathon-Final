variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group."
  type        = number
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in."
  type        = list(string)
}

variable "image_id" {
  description = "The AMI from which to launch the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch."
  type        = string
}

variable "public_key" {
  description = "provide the public key as string."
  type        = string
}


variable "security_groups" {
  description = "A list of associated security group IDS."
  type        = list(string)
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = ""
}
# Define variables
variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., prod, dev, staging)"
  type        = string
}

variable "instance_profile" {
  description = "The instance profile"
  type        = string

}
