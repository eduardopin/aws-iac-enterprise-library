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
