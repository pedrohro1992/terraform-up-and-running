terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-20230920"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
  }
}