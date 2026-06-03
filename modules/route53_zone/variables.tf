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

variable "domain_name" {
  type        = string
  description = "Domain name."
  nullable    = false
}
