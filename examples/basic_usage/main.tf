# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Define the module for ElastiCache Slack Alarms
module "elasticache_slack_alarms" {
  source = "github.com/kubenine/aws-elasticache-alarms.git"  # Adjust the path based on your module's location

  # Mandatory variables
  cache_cluster_id   = "kubenine-0001-001"  # Replace with your ElastiCache cluster ID
  cache_node_id      = "0001"           # Replace with your cache node ID
  slack_webhook_url  = "https://hooks.slack.com/services/BJFKWJFKFNFN743J4H8RWBR43HN33BRBEJKSJ"  # Replace with your Slack webhook URL

 
  slack_channel  = "slack-notifications"  # Slack channel where notifications will be sent
  slack_username = "slack"                # Username that will appear in Slack messages

  # Enable or disable specific alarms (set to true or false)
  enable_high_cpu_alarm         = false   # Alarm for high overall CPU utilization
  enable_engine_cpu_alarm       = true   # Alarm for high Redis engine CPU utilization
  # Thresholds for alarms (adjust as needed)
  cpu_percent_threshold            = 90    # Threshold (%) for high CPU utilization alarm

}
