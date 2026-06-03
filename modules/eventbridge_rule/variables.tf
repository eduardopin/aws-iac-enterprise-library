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
  default     = "Managed EventBridge rule"
}

variable "schedule_expression" {
  type        = string
  description = "Schedule expression."
  default     = null
}

variable "event_pattern" {
  type        = string
  description = "Event pattern."
  default     = null
}
