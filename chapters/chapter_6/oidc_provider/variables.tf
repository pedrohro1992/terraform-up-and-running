variable "allowed_repos_branches" {
  description = "GitHub repos/branch allowed to assume the IAM role"
  type = list(object({
    org    = string
    repo   = string
    branch = string
  }))
  default = [{
    org    = "pedrohro1992"
    repo   = "terraform-up-and-running"
    branch = "main"
  }]
}
