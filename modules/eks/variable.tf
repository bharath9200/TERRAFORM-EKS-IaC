variable "iam_role_for_cluster" {
  description = "This variable is for iam role for eks cluster control plane"
  type        = string
}


variable "cluster_name" {
  description = "This variable is for eks cluster name"
  type        = string
}

variable "cluster_version" {
  description = "This variable is for eks cluster Version"
  type        = string
}

variable "instance_type" {
  description = "This variable is for node group instance type"
  type = list(string)
}


variable "cluster_tags" {
  description = "This variable is for eks node-group tags for instances"
  type        = map(string)
}

variable "subnet_ids" {
  description = "This variable is for defining the private subnet ids to the eks cluster"
  type        = list(string)
}