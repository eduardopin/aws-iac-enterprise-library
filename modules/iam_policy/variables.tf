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
  default     = "Managed IAM policy"
}

variable "policy_json" {
  type        = string
  description = "Policy json."
  default     = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
}
