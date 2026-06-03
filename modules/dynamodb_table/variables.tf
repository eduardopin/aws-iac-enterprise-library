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

variable "hash_key" {
  type        = string
  description = "Hash key."
  default     = "id"
}

variable "hash_key_type" {
  type        = string
  description = "Hash key type."
  default     = "S"
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  description = "Point in time recovery enabled."
  default     = true
}
