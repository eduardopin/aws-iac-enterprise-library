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

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name."
  nullable    = false
}

variable "is_multi_region_trail" {
  type        = bool
  description = "Is multi region trail."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "Kms key id."
  default     = null
}
