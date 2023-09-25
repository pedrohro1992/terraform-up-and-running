provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "git@github.com:pedrohro1992/terraform-modules.git//services/webserver-cluster?ref=v0.0.1"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-20230922"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  max_size      = 2
  min_size      = 2
}


resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}
