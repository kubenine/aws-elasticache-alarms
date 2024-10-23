# AWS ElastiCache Alarms Module

This Terraform module helps you configure AWS CloudWatch alarms for monitoring your ElastiCache clusters and sends notifications to Slack. The module monitors key ElastiCache metrics like CPU utilization, replication lag, evictions, swap usage, and current connections, and notifies your specified Slack channel when thresholds are crossed.

## Features

- Create CloudWatch alarms for ElastiCache clusters
- Monitor key metrics such as CPU, replication lag, evictions, and swap usage
- Send alarm notifications to a Slack channel
- Customize alarm thresholds and enable/disable alarms as needed

## Usage

Here’s an example of how to use the module in your Terraform configuration.

```hcl
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Define the module for ElastiCache Slack Alarms
module "elasticache_slack_alarms" {
  source = "../../"  # Use your GitHub repo as the source

  # Mandatory variables
  cache_cluster_id   = "your-elasticache-cluster-id"  # Replace with your ElastiCache cluster ID
  cache_node_id      = "your-cache-node-id"           # Replace with your cache node ID
  slack_webhook_url  = "https://hooks.slack.com/services/your/webhook/url"  # Replace with your Slack webhook URL

  # Optional Slack settings
  slack_channel  = "slack-notifications"  # Slack channel where notifications will be sent
  slack_username = "slack"                # Username that will appear in Slack messages

  # Enable or disable specific alarms (set to true or false)
  enable_high_cpu_alarm         = true   # Alarm for high overall CPU utilization
  enable_engine_cpu_alarm       = true   # Alarm for high Redis engine CPU utilization
  enable_replication_lag_alarm  = true   # Alarm for replication lag
  enable_evictions_alarm        = true   # Alarm for cache evictions
  enable_currconnections_alarm  = true   # Alarm for high number of current connections
  enable_swap_alarm             = true   # Alarm for high swap usage

  # Thresholds for alarms (adjust as needed)
  cpu_percent_threshold            = 90    # Threshold (%) for high CPU utilization alarm
  engine_cpu_percent_threshold     = 80    # Threshold (%) for Redis engine CPU utilization alarm
  evictions_threshold              = 0     # Threshold for cache evictions alarm
  current_connections_threshold    = 1000  # Threshold for current connections alarm
  swap_threshold                   = 262144000  # Threshold (bytes) for swap usage alarm
  replication_lag_threshold         = 90    # Threshold for replication lag alarm (seconds)

  # Additional optional settings (if any)
  # region = "us-east-1"  # AWS region (if different from provider region)
}
