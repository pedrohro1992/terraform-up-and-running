resource "aws_instance" "example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  subnet_id = "subnet-04bc71c81d59eb550"
}