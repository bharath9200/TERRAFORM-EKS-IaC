Project = "Devfolio"

vpc_cidr = "10.110.0.0/16"

subnet_config = {
  "pub1" = { cidr = "10.110.1.0/24", az = "us-east-1a", type = "public" }
  "pub2" = { cidr = "10.110.2.0/24", az = "us-east-1b", type = "public" }
  "pri1" = { cidr = "10.110.3.0/24", az = "us-east-1a", type = "private" }
  "pri2" = { cidr = "10.110.4.0/24", az = "us-east-1b", type = "private" }
}

whole_route = "0.0.0.0/0"

provider_region = "us-east-1"


# Eks variable values

cluster_name         = "devfolio-cluster"
cluster_version      = "1.35"
cluster_tags         = {}
iam_role_for_cluster = "custom-role-eks-cluster"
instance_type = [ "t3.micro" ]