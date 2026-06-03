variable "name" {
  type        = string
  description = "Name."
  nullable    = false
}

variable "tags" {
  type        = map(string)
  description = "Tags."
  default     = {}
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "Visibility timeout seconds."
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "Message retention seconds."
  default     = 345600
}
