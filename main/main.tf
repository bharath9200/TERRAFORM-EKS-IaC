module "vpc" {
  source = "../vpc"

  Project = var.Project

  vpc_cidr = var.vpc_cidr

  subnet_config = var.subnet_config

  whole_route = var.whole_route

}

module "ecr" {
  source    = "../ecr"
  ecr_repos = ["web", "app", "db"]

}


module "eks" {
  source = "../eks"

  subnet_ids           = module.vpc.private_subnet_ids
  cluster_name         = var.cluster_name
  cluster_version      = var.cluster_version
  cluster_tags         = var.cluster_tags
  iam_role_for_cluster = var.iam_role_for_cluster
  instance_type        = var.instance_type

}