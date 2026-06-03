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
  default     = "aurora-postgresql"
}

variable "engine_version" {
  type        = string
  description = "Engine version."
  default     = "16.1"
}

variable "database_name" {
  type        = string
  description = "Database name."
  default     = "app"
}

variable "master_username" {
  type        = string
  description = "Master username."
  default     = "admin"
}

variable "master_password" {
  type        = string
  description = "Master password."
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
