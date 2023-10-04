output "region_1" {
  value       = data.aws_region.region_1.name
  description = "The name of the first region"
}

output "region_2" {
  value       = data.aws_region.region_2.name
  description = "The name of the second region"
}

output "intance_reion_1_az" {
  value = aws_instance.region_1.availability_zone
}

output "intance_reion_2_az" {
  value = aws_instance.region_2.availability_zone
}

