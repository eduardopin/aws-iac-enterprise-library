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

variable "kms_key_arn" {
  type        = string
  description = "Kms key arn."
  default     = null
}
