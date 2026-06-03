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

variable "role_arn" {
  type        = string
  description = "Role arn."
  nullable    = false
}
