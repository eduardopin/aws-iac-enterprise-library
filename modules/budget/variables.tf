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

variable "limit_amount" {
  type        = string
  description = "Limit amount."
  default     = "1000"
}

variable "time_unit" {
  type        = string
  description = "Time unit."
  default     = "MONTHLY"
}
