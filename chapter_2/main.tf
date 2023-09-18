resource "aws_instance" "example" {
    ami = "ami-01103fb68b3569475"
    instance_type = "t2.micro"

    tags = {
      Name = "terraform-example"
    }
  
}