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

variable "group_name" {
  type        = string
  description = "Group name."
  default     = "default"
}

variable "schedule_expression" {
  type        = string
  description = "Schedule expression."
  default     = "rate(1 day)"
}

variable "target_arn" {
  type        = string
  description = "Target arn."
  nullable    = false
}

variable "role_arn" {
  type        = string
  description = "Role arn."
  nullable    = false
}

variable "input" {
  type        = string
  description = "Input."
  default     = "{}"
}
