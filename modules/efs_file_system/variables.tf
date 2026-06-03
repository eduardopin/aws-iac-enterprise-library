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

variable "performance_mode" {
  type        = string
  description = "Performance mode."
  default     = "generalPurpose"
}

variable "throughput_mode" {
  type        = string
  description = "Throughput mode."
  default     = "bursting"
}
