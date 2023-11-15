terraform {
  backend "s3" {

  }
}

module "mysql" {
  source = "../../../../../../../terraform-modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

}
