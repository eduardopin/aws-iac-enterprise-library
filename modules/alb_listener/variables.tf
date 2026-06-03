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

variable "load_balancer_arn" {
  type        = string
  description = "Load balancer arn."
  nullable    = false
}

variable "port" {
  type        = number
  description = "Port."
  default     = 443
}

variable "protocol" {
  type        = string
  description = "Protocol."
  default     = "HTTPS"
}

variable "certificate_arn" {
  type        = string
  description = "Certificate arn."
  nullable    = false
}

variable "target_group_arn" {
  type        = string
  description = "Target group arn."
  nullable    = false
}
