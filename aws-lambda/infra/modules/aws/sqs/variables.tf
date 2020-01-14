variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
  default     = 86400
}