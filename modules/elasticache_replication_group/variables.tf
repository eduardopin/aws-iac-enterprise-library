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

variable "description" {
  type        = string
  description = "Description."
  default     = "Managed Redis replication group"
}

variable "node_type" {
  type        = string
  description = "Node type."
  default     = "cache.t4g.micro"
}

variable "num_cache_clusters" {
  type        = number
  description = "Num cache clusters."
  default     = 1
}

variable "subnet_group_name" {
  type        = string
  description = "Subnet group name."
  nullable    = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}
