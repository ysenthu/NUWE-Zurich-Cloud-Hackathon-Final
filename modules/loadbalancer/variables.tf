variable "name" {
  description = "The prefix for the resources' names"
  type        = string
}
variable "environment" {
  description = "The environment of the resources"
  type        = string
}

variable "asg_name" {
  description = "The name of the ASG to attach to the NLB"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the NLB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the resources"
  type        = string
}

variable "ports" {
  description = "Map of ports and protocols for the target group and listener."
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [
    {
      port     = 443
      protocol = "TCP"
    },
    {
      port     = 1337
      protocol = "TCP"
    },
    {
      port     = 3035
      protocol = "TCP_UDP"
    }
  ]
}
