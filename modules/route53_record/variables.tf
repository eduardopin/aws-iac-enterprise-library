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

variable "zone_id" {
  type        = string
  description = "Zone id."
  nullable    = false
}

variable "type" {
  type        = string
  description = "Type."
  default     = "A"
}

variable "ttl" {
  type        = number
  description = "Ttl."
  default     = 300
}

variable "records" {
  type        = list(string)
  description = "Records."
  nullable    = false
}
