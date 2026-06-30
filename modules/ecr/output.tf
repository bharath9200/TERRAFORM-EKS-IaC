output "repo_name" {
  description = "Repository names"
  value       = [for repo_name in aws_ecr_repository.ecr_repo : repo_name.name]
  #value = values(aws_ecr_repository.ecr_repo)
}