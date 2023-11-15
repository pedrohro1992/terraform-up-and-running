variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true

}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "The name of the RDS DataBase"
  default     = "example_database_stage"
}
