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

variable "output_location" {
  type        = string
  description = "Output location."
  nullable    = false
}
