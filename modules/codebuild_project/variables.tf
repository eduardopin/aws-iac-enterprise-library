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

variable "service_role_arn" {
  type        = string
  description = "Service role arn."
  nullable    = false
}

variable "compute_type" {
  type        = string
  description = "Compute type."
  default     = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  type        = string
  description = "Image."
  default     = "aws/codebuild/standard:7.0"
}

variable "source_type" {
  type        = string
  description = "Source type."
  default     = "NO_SOURCE"
}
