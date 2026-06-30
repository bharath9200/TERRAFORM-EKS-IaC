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

variable "provider_region" {
  description = "This variable is for provider's region"
  type        = string
}


#EKS variables

variable "cluster_name" {
  description = "This variable is for eks cluster name"
  type        = string
}

variable "cluster_version" {
  description = "This variable is for eks cluster version"
  type        = string
}

variable "cluster_tags" {
  description = "This variable is for eks node-group tags for instances"
  type        = map(string)
}

variable "iam_role_for_cluster" {
  description = "This variable is for iam role for eks cluster control plane"
  type        = string
}

variable "instance_type" {
  description = "This variable is for node group instance type"
  type = list(string)
}