module "simple_webapp" {
  source = "/home/poliveira/Workspace/personal/terraform-modules/services/k8s-app"

  name           = "simple-webapp"
  image          = "training/webapp"
  replicas       = 2
  containet_port = 80

  create_lb_eks = true
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "rancher-desktop"
}
