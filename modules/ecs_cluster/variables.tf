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

variable "container_insights_enabled" {
  type        = bool
  description = "Container insights enabled."
  default     = true
}
