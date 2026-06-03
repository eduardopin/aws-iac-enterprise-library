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

variable "max_size" {
  type        = number
  description = "Max size."
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Min size."
  default     = 1
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity."
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids."
  nullable    = false
}

variable "launch_template_id" {
  type        = string
  description = "Launch template id."
  nullable    = false
}

variable "launch_template_version" {
  type        = string
  description = "Launch template version."
  default     = "$Latest"
}
