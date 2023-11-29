variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
  default     = "ami-024e6efaf93d85776"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string

}

variable "min_size" {
  description = "The minimum number of EC2 instances in the ASG"
  type        = number

  validation {
    condition     = var.min_size > 0
    error_message = "ASGs can't be empty or we'll have an outage!"
  }

  validation {
    condition     = var.min_size <= 10
    error_message = "ASGs must have 10 or fewer instances to keep costs down"
  }
}

variable "max_size" {
  description = "The maximum numbe of the EC2 Instances in the ASG"
  type        = number
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto-scaling on resources"
  type        = bool
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "server_text" {
  description = "The text the webserver should return"
  type        = string
  default     = "Hello, World"
}

variable "subnets_ids" {
  description = "The subnet IDs to deploy to"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARNs of ELB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The type of health check to perform. Must be one of: EC2, ELB."
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "The User Data script to run un each Instance at boot"
  type        = string
  default     = null
}
