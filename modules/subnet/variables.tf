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

variable "vpc_id" {
  type        = string
  description = "Vpc id."
  nullable    = false
}

variable "cidr_block" {
  type        = string
  description = "Cidr block."
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone."
  nullable    = false
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public ip on launch."
  default     = false
}
