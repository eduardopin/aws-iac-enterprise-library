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

variable "role_arn" {
  type        = string
  description = "Role arn."
  nullable    = false
}

variable "handler" {
  type        = string
  description = "Handler."
  default     = "index.handler"
}

variable "runtime" {
  type        = string
  description = "Runtime."
  default     = "python3.12"
}

variable "filename" {
  type        = string
  description = "Filename."
  default     = "function.zip"
}

variable "timeout" {
  type        = number
  description = "Timeout."
  default     = 30
}

variable "memory_size" {
  type        = number
  description = "Memory size."
  default     = 256
}

variable "log_retention_days" {
  type        = number
  description = "Log retention days."
  default     = 30
}

variable "tracing_mode" {
  type        = string
  description = "Tracing mode."
  default     = "Active"
}
