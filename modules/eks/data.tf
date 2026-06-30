data "aws_iam_role" "for_pod_identity" {
  name = "AmazonEKS_CNI_DriverRole"
}


data "aws_iam_user" "iam_user_name" {
  user_name = "aws-cli-admin"
}


