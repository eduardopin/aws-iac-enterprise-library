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
  default     = "Managed KMS key"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Deletion window in days."
  default     = 30
}
