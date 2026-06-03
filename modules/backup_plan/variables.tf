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

variable "target_vault_name" {
  type        = string
  description = "Target vault name."
  nullable    = false
}

variable "schedule" {
  type        = string
  description = "Schedule."
  default     = "cron(0 5 ? * * *)"
}

variable "delete_after_days" {
  type        = number
  description = "Delete after days."
  default     = 35
}
