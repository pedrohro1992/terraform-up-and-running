variable "mysql_config" {
  description = "The config for the MySQL DB"

  type = object({
    address = string
    port    = number
  })

  default = {
    address = "mock-mysql-address"
    port    = 12345
  }
}
variable "cluster_name" {
  description = "The name of the cluster congig"
  type        = string
  default     = "cluster-example"
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the dabase's remote state in S3"
  type        = string
}

variable "environment" {
  description = "The name of the environment we-re deploying to"
  type        = string
  default     = "stage"
}
