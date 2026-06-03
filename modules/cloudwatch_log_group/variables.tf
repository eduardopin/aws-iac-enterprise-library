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

variable "retention_in_days" {
  type        = number
  description = "Retention in days."
  default     = 30
}

variable "kms_key_id" {
  type        = string
  description = "Kms key id."
  default     = null
}
