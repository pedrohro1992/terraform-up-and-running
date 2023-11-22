provider "aws" {
  region = "us-east-2"
}


resource "aws_instance" "example" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
     ManagedBy = "terraform"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}