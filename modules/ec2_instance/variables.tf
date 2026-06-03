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

variable "ami_id" {
  type        = string
  description = "Ami id."
  nullable    = false
}

variable "instance_type" {
  type        = string
  description = "Instance type."
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id."
  nullable    = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids."
  default     = []
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate public ip address."
  default     = false
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size."
  default     = 20
}
