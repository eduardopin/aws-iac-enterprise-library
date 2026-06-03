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

variable "capacity_type" {
  type        = string
  description = "Capacity type."
  default     = "spot"
}

variable "instance_family" {
  type        = string
  description = "Instance family."
  default     = "m6i"
}
