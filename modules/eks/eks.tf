resource "aws_iam_role" "cluster" {

  name = var.iam_role_for_cluster

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_eks_cluster" "eks" {
  name = var.cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]

  bootstrap_self_managed_addons = true #default is true -- here vpc_cni, coredns, kube-proxy are going to install automatically

}


resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "eks-pod-identity-agent"
}


resource "aws_eks_pod_identity_association" "pod_identity_associate" {
  cluster_name    = aws_eks_cluster.eks.name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = data.aws_iam_role.for_pod_identity.arn # Role must have AmazonEKS_CNI_Policy attached.

  depends_on = [aws_eks_addon.pod_identity_agent, aws_eks_cluster.eks]
}


# This resource maps your IAM user to Kubernetes cluster permissions
resource "aws_eks_access_entry" "admin_user" {
  cluster_name      = aws_eks_cluster.eks.name
  principal_arn     =data.aws_iam_user.iam_user_name.arn # Replace with your actual user ARN
  #kubernetes_groups = ["system:masters"] # Optional: maps to K8s groups
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = data.aws_iam_user.iam_user_name.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}