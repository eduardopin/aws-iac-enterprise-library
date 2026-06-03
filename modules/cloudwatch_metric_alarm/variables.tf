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

variable "comparison_operator" {
  type        = string
  description = "Comparison operator."
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  type        = number
  description = "Evaluation periods."
  default     = 1
}

variable "metric_name" {
  type        = string
  description = "Metric name."
  default     = "CPUUtilization"
}

variable "namespace" {
  type        = string
  description = "Namespace."
  default     = "AWS/EC2"
}

variable "period" {
  type        = number
  description = "Period."
  default     = 300
}

variable "statistic" {
  type        = string
  description = "Statistic."
  default     = "Average"
}

variable "threshold" {
  type        = number
  description = "Threshold."
  default     = 80
}

variable "description" {
  type        = string
  description = "Description."
  default     = "Managed alarm"
}

variable "alarm_actions" {
  type        = list(string)
  description = "Alarm actions."
  default     = []
}
