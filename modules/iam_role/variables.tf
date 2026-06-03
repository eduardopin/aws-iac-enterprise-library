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

variable "principal_type" {
  type        = string
  description = "Principal type."
  default     = "Service"
}

variable "principal_identifiers" {
  type        = list(string)
  description = "Principal identifiers."
  default     = ["ec2.amazonaws.com"]
}
