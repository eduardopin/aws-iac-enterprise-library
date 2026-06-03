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

variable "cluster_arn" {
  type        = string
  description = "Cluster arn."
  nullable    = false
}

variable "task_definition_arn" {
  type        = string
  description = "Task definition arn."
  nullable    = false
}

variable "desired_count" {
  type        = number
  description = "Desired count."
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign public ip."
  default     = false
}
