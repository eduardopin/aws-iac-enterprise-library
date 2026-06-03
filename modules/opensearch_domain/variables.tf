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

variable "engine_version" {
  type        = string
  description = "Engine version."
  default     = "OpenSearch_2.11"
}

variable "instance_type" {
  type        = string
  description = "Instance type."
  default     = "t3.small.search"
}

variable "instance_count" {
  type        = number
  description = "Instance count."
  default     = 1
}
