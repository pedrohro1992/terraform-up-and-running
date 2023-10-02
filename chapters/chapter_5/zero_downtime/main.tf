module "webserver_cluster" {
  source = "/home/poliveira/Workspace/personal/terraform-modules/services/webserver-cluster"

  ami         = "ami-024e6efaf93d85776"
  server_text = "Newer Server Text"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-20230922"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false

  custom_tags = {
    foo = "bar"
  }
}
