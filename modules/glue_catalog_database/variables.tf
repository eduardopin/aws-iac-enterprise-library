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
  default     = "Managed Glue database"
}
