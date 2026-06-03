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

variable "transit_gateway_id" {
  type        = string
  description = "Transit gateway id."
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
  nullable    = false
}
