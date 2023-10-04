module "rds_primary" {
  source = "/home/poliveira/Workspace/personal/terraform-modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name     = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  # Must be enable to support replication
  backup_retention_period = 1
}

module "rds_replica" {
  source = "/home/poliveira/Workspace/personal/terraform-modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  # Make this a replica of the primary
  replicate_source_db = module.rds_primary.arn

}
