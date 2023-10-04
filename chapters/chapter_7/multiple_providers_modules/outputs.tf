output "primary_address" {
  value       = module.rds_primary.address
  description = "Connect to the primary database at this endpoint"
}

output "primary_port" {
  value       = module.rds_primary.port
  description = "The port the primary database is listening on"
}

output "primary_arn" {
  value       = module.rds_primary.arn
  description = "The ARN of the primary database"
}

output "replica_address" {
  value       = module.rds_replica.address
  description = "Connect to the replica database at this endpoint"
}

output "replica_port" {
  value       = module.rds_replica.port
  description = "The port the replica database is listening on"
}

output "replica_arn" {
  value       = module.rds_replica.arn
  description = "The Arn of the replica database"
}
