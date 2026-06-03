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

variable "cidr_block" {
  type        = string
  description = "Cidr block."
  default     = "10.0.0.0/16"
}
