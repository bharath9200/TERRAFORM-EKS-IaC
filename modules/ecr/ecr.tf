resource "aws_ecr_repository" "ecr_repo" {
  for_each             = toset(var.ecr_repos)
  name                 = "devfolio-${each.key}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  for_each   = toset(var.ecr_repos)
  repository = aws_ecr_repository.ecr_repo[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the last 5 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}