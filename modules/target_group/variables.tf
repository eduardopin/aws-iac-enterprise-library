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

variable "port" {
  type        = number
  description = "Port."
  default     = 80
}

variable "protocol" {
  type        = string
  description = "Protocol."
  default     = "HTTP"
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
  nullable    = false
}

variable "target_type" {
  type        = string
  description = "Target type."
  default     = "ip"
}

variable "health_check_path" {
  type        = string
  description = "Health check path."
  default     = "/health"
}
