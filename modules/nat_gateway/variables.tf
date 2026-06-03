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

variable "allocation_id" {
  type        = string
  description = "Allocation id."
  nullable    = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet id."
  nullable    = false
}
