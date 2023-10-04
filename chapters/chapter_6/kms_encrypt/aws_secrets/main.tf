# Retrieve secrets from Aws Secret Manager using a data source 
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "db-creds"
}

# Since the secrets come on a JSON format, the code uses a local to converte the value
locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = var.db_name

  # Pass the secrets to the resource
  username = local.db_creds.username
  password = local.db_creds.password
}
