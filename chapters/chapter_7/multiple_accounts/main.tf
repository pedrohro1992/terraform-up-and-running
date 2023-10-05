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

data "aws_caller_identity" "parent" {
  provider = aws.parent
}

data "aws_caller_identity" "child" {
  provider = aws.child
}

output "parent_account_id" {
  value = data.aws_caller_identity.parent.account_id
}

output "child_account_id" {
  value = data.aws_caller_identity.child.account_id
}

