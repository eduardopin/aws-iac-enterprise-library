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

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version."
  default     = "1.30"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}

variable "endpoint_public_access" {
  type        = bool
  description = "Endpoint public access."
  default     = false
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "Enabled cluster log types."
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}
