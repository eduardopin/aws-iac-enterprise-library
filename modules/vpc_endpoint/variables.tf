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

variable "vpc_id" {
  type        = string
  description = "Vpc id."
  nullable    = false
}

variable "service_name" {
  type        = string
  description = "Service name."
  nullable    = false
}

variable "vpc_endpoint_type" {
  type        = string
  description = "Vpc endpoint type."
  default     = "Interface"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}
