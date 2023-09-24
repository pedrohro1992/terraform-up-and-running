terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state-20230922"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
