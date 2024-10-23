
## Mandatory variables
variable "cache_cluster_id" {
  description = "Elasticache cluster ID"
}

variable "slack_webhook_url" {
  description = "Slack webhook URL"
  type = string
}

variable "slack_channel" {
  description = "Slack channel for notifications"
  type        = string
  default     = "airflow-notifications"
}

variable "slack_username" {
  description = "Slack username for notifications"
  type        = string
  default     = "reporter"
}

## Mandatory variables end here

## Optional variables start here
variable "region" {
  description = "Region"
  default = "us-east-1"
}

### Variables to enable/disable alarms
variable "enable_high_cpu_alarm" {
  description = "Enable or disable the high CPU utilization alarm"
  type        = bool
  default     = true
}
variable "enable_engine_cpu_alarm" {
  description = "Enable or disable the Redis engine CPU utilization alarm"
  type        = bool
  default     = true
}

variable "enable_replication_lag_alarm" {
  description = "Enable or disable the replication lag alarm"
  type        = bool
  default     = true
}

variable "enable_evictions_alarm" {
  description = "Enable or disable the evictions alarm"
  type        = bool
  default     = true
}

variable "enable_currconnections_alarm" {
  description = "Enable or disable the current connections alarm"
  type        = bool
  default     = true
}
variable "enable_swap_alarm" {
  description = "Enable or disable the swap usage alarm"
  type        = bool
  default     = true
}



### Variables to set thresholds for alarms
variable "evictions_threshold" {
  description = "Threshold for evictions alarm"
  type        = string
  default     = "0"
}

variable "cpu_percent_threshold" {
  description = "Threshold for cpu alarm in %"
  type        = number
  default     = 90
}

variable "low_cpu_percent_threshold" {
  description = "Threshold for low CPU utilization alarm in %"
  type        = number
  default     = 10
}

variable "swap_threshold" {
  description = "Threshold for swap alarm"
  type        = number
  default     = 262144000
}

variable "engine_cpu_percent_threshold" {
  description = "Threshold for Redis engine CPU utilization alarm in %"
  type        = number
  default     = 80
}

variable "current_connections_threshold" {
  description = "Threshold for current connections alarm"
  type        = number
  default     = 1000
}

variable "replication_lag_threshold" {
  description = "elasticache-alarm-replication-lag"
  type        = number
  default     = 100
  
}