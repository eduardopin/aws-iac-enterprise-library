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

variable "cors_allow_methods" {
  type        = list(string)
  description = "Cors allow methods."
  default     = ["GET", "POST", "OPTIONS"]
}

variable "cors_allow_origins" {
  type        = list(string)
  description = "Cors allow origins."
  default     = ["*"]
}
