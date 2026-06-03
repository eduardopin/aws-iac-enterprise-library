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

variable "cluster_name" {
  type        = string
  description = "Cluster name."
  nullable    = false
}

variable "node_role_arn" {
  type        = string
  description = "Node role arn."
  nullable    = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types."
  default     = ["t3.medium"]
}

variable "desired_size" {
  type        = number
  description = "Desired size."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Max size."
  default     = 3
}

variable "min_size" {
  type        = number
  description = "Min size."
  default     = 1
}
