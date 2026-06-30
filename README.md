# TERRAFORM-EKS-IaC
☁️ Infrastructure as Code: Terraform EKS Foundation

Scalable, Secure, and Production-Ready AWS Kubernetes Deployment
Welcome to the TERRAFORM-EKS-IaC repository. This project serves as the foundational infrastructure layer for a high-availability EKS environment. By utilizing a hybrid approach—combining optimized modules for networking and granular resource control for compute—this setup ensures both operational efficiency and deep security.

🎯 Architecture Philosophy
This infrastructure is built with "Zero Trust" and "High Availability" at its core. By isolating Kubernetes worker nodes within private subnets and leveraging modern IAM authentication, we ensure a hardened production environment.

🏗️ Core Pillars
Networking (VPC): Modular architecture for automated sub-netting and traffic flow.

Compute (EKS): Native resource provisioning for fine-grained control over node groups.

Security: Transitioning away from legacy OIDC/IRSA to modern EKS Pod Identity for granular service-level permissions.

Reliability: S3-backed remote state with DynamoDB state locking to prevent concurrency collisions.

🏗️ Key Modules
🌐 VPC Module: Standardizes networking for all environments, ensuring private/public subnet isolation.
☸️ EKS Module: Encapsulates Cluster provisioning, IAM roles, and managed node group orchestration.📦 ECR Module: Provides a centralized, secure repository for your container images.

⚡ Deployment Workflow

To deploy the infrastructure, you interact primarily with the main/ directory:

Initialize the Environment:
Bash
cd main
terraform init

Validate the Plan:
Bash
terraform plan -var-file=terraform.tfvars

Apply Configuration:
Bashterraform apply -var-file=terraform.tfvars

🛡️ DevOps Best Practices Implemented
DRY Architecture: Logic is defined once in modules/ and reused across environments.
State Integrity: Managed via backend.tf with remote state locking (S3/DynamoDB).
Resource Separation: Clear isolation between networking (VPC), storage (ECR), and compute (EKS).

🛠️ Tech Stack
Category        Technology
Language        Terraform
PlatformAWS     (VPC, EKS, ECR, S3, IAM)
Architecture     Modular Infrastructure
