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

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}
