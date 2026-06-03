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

variable "kms_master_key_id" {
  type        = string
  description = "Kms master key id."
  default     = null
}
