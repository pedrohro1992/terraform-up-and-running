provider "aws" {
  region = "us-east-2"
  alias  = "parent"
}

provider "aws" {
  region = "us-east-2"
  alias  = "child"

  assume_role {
    role_arn = "arn:aws:iam::065051802737:role/OrganizationAccountAccessRole"
  }
}

module "multi_account_example" {
  source = "../multiple_accounts_module"

  providers = {
    aws.parent = aws.parent
    aws.child  = aws.child
  }
}

output "parent" {
  value = module.multi_account_example.parent_account_id
}

output "child" {
  value = module.multi_account_example.child_account_id
}

