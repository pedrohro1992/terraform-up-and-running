data "aws_vpc" "default" {
  default = true
}
d

data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [ data.aws_vpc.default.id ]
      
    }
  
}
