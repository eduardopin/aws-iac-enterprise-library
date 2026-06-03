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

variable "versioning_enabled" {
  type        = bool
  description = "Versioning enabled."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "Kms key id."
  default     = null
}
