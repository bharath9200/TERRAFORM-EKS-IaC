output "vpc_id_value" {
  description = "This is a value of VPC Id"
  value       = module.vpc.vpc_id_value
}

output "vpc_private_subnet_ids" {
  description = "This value is used to fetch all subnets"
  value       = module.vpc.private_subnet_ids
}

output "repo_names" {
  description = "This value is used to fetch all repositories"
  value       = module.ecr.repo_name
}

