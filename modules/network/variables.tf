# Define variables
variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., prod, dev, staging)"
  type        = string
}


variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# List of AZs in the region
variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}


variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]  # Example CIDRs
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]  # Example CIDRs
}

