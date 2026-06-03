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

variable "description" {
  type        = string
  description = "Description."
  default     = "Managed by Terraform"
}

variable "ingress_rules" {
  type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional(string) }))
  description = "Ingress rules."
  default     = []
}
