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

variable "description" {
  type        = string
  description = "Description."
  default     = "Managed parameter"
}

variable "type" {
  type        = string
  description = "Type."
  default     = "SecureString"
}

variable "value" {
  type        = string
  description = "Value."
  default     = "CHANGE_ME"
}

variable "kms_key_id" {
  type        = string
  description = "Kms key id."
  default     = null
}
