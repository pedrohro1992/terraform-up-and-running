variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_name" {
  type        = string
  description = "The name of the RDS DataBase"
  default     = null
}

variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication"
  type        = number
  default     = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS database at the given ARN"
  type        = string
  default     = null
}
