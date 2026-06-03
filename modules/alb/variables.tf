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

variable "internal" {
  type        = bool
  description = "Internal."
  default     = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}
