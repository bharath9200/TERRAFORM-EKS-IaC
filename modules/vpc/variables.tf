variable "Project" {
  description = "This variable is for Project Name"
  type        = string
}

variable "vpc_cidr" {
  description = "This variable is for VPC_CIDR"
  type        = string
}

variable "subnet_config" {
  description = "This variable is for subnet_cidr, type, availability zones"
  type = map(object({
    cidr = string
    az   = string
    type = string
  }))
}

variable "whole_route" {
  description = "This variable is for total route from subnets to IGW and NGW"
  type        = string
}
