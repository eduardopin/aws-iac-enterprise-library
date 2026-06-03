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

variable "default_root_object" {
  type        = string
  description = "Default root object."
  default     = "index.html"
}

variable "origin_domain_name" {
  type        = string
  description = "Origin domain name."
  nullable    = false
}

variable "origin_id" {
  type        = string
  description = "Origin id."
  default     = "primary-origin"
}
