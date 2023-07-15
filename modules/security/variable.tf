variable "name" {
  description = "Name for the security group"
  type        = string
}

variable "description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group created by Terraform"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "ingress_rules" {
  description = "Ingress rules for the security group"
  type        = list(map(string))
}
variable "egress_rules" {
  description = "Ingress rules for the security group"
  type        = list(map(string))
  default = [{
    "from_port"      = 0
    "to_port"        = 0
    protocol         = "-1"
    cidr_blocks      = "0.0.0.0/0"

  }]
}
