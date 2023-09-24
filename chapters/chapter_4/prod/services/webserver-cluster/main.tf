provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster/"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-20230922"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "m4.large"
  max_size      = 2
  min_size      = 10
}
