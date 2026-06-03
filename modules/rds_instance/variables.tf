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

variable "engine" {
  type        = string
  description = "Engine."
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Engine version."
  default     = "16"
}

variable "instance_class" {
  type        = string
  description = "Instance class."
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage."
  default     = 20
}

variable "username" {
  type        = string
  description = "Username."
  default     = "admin"
}

variable "password" {
  type        = string
  description = "Password."
  nullable    = false
}

variable "db_subnet_group_name" {
  type        = string
  description = "Db subnet group name."
  nullable    = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period."
  default     = 7
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot."
  default     = true
}
