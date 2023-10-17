provider "aws" {
  region = "us-east-2"
}

module "eks_cluster" {
  source = "/home/pedro/Workspace/personal/projects/terraform-modules/services/eks-cluster"

  name         = "example-eks-cluster"
  min_size     = 1
  max_size     = 2
  desired_size = 1

  instance_types = ["t3.small"]
}

# provider "kubernetes" {
#   host                   = module.eks_cluster.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks_cluster.cluster_name
# }

# module "simple_webapp" {
#   source = "/home/poliveira/Workspace/personal/terraform-modules/services/k8s-app"

#   name           = "simple-webapp"
#   image          = "training/webapp"
#   replicas       = 2
#   containet_port = 5000

#   environment_variables = {
#     PROVIDER = "terraform"
#   }

#   create_lb_eks = true

#   #Only deploy the app after the cluster has been deployed
#   depends_on = [module.eks_cluster]
# }

# output "service_endpoint" {
#   value       = module.simple_webapp.service_endpoint
#   description = "The K8s Endpoint"
# }
