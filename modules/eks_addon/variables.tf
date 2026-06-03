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

variable "addon_name" {
  type        = string
  description = "Addon name."
  nullable    = false
}

variable "addon_version" {
  type        = string
  description = "Addon version."
  default     = null
}
