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

variable "cpu" {
  type        = number
  description = "Cpu."
  default     = 256
}

variable "memory" {
  type        = number
  description = "Memory."
  default     = 512
}

variable "execution_role_arn" {
  type        = string
  description = "Execution role arn."
  nullable    = false
}

variable "task_role_arn" {
  type        = string
  description = "Task role arn."
  default     = null
}

variable "container_definitions" {
  type        = string
  description = "Container definitions."
  nullable    = false
}
