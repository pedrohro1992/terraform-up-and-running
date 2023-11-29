variable "name" {
  description = "The name to use for all resources created by this module"
  type        = string
}

variable "image" {
  description = "The container image to run"
  type        = string
}

variable "containet_port" {
  description = "The port the container image listens on"
  type        = number
}

variable "replicas" {
  description = "How many replicas to run"
  type        = number
}

variable "environment_variables" {
  description = "Enviroment variables to set for the app"
  type        = map(string)
  default     = {}
}

variable "create_lb_eks" {
  description = "If set to true, the service type will be LoadBalancer"
  type        = bool
}
