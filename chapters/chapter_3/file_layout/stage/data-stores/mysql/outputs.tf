output "address" {
    value = aws_db_instance.example.address
    description = "Connect ti the database at this endpoint"  
}

output "port" {
  value = aws_db_instance.example.port
  description = "The port the database is listining on"
}