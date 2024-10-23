provider "aws" {
    region = var.region 
}

module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 5.0"
  sns_topic_name = "elasticache-slack-${var.cache_cluster_id}"
  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username
  
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_high_cpu" {
  count               = var.enable_high_cpu_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-cpu-${var.cache_cluster_id}"
  alarm_description   = "Overall CPU utilization on ${var.cache_cluster_id} reached ${var.cpu_percent_threshold}%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = var.cpu_percent_threshold
  statistic           = "Average"
  alarm_actions = [module.notify_slack.slack_topic_arn]
  ok_actions = [module.notify_slack.slack_topic_arn]

  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}

# The difference between alarm_high_cpu and alarm_engine_cpu:
# - alarm_high_cpu monitors overall CPU utilization, including both Redis and OS operations
# - alarm_engine_cpu specifically tracks Redis engine CPU usage, excluding OS-level operations
# This distinction helps in identifying whether high CPU usage is due to Redis workload or system-level tasks
resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_engine_cpu" {
  count               = var.enable_engine_cpu_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-engine-cpu-${var.cache_cluster_id}"
  alarm_description   = "Redis Engine CPU utilization (excluding OS operations) on ${var.cache_cluster_id} is above ${var.engine_cpu_percent_threshold}%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EngineCPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = var.engine_cpu_percent_threshold
  statistic           = "Average"
  alarm_actions       = [module.notify_slack.slack_topic_arn]
  ok_actions          = [module.notify_slack.slack_topic_arn]

  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_replication_lag" {
  count = var.enable_replication_lag_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-replication-lag-${var.cache_cluster_id}"
  alarm_description   = "Replication lag on ${var.cache_cluster_id} is above 100 seconds"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "ReplicationLag"
  namespace           = "AWS/ElastiCache"
  period              = 60
  threshold           = var.replication_lag_threshold
  statistic           = "Average"
  alarm_actions       = [module.notify_slack.slack_topic_arn]
  ok_actions          = [module.notify_slack.slack_topic_arn]

  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_evictions" {
  count = var.enable_evictions_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-evictions-${var.cache_cluster_id}"
  alarm_description   = "Evictions for ${var.cache_cluster_id} have been greater than 0 for at least 30 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Evictions"
  namespace           = "AWS/ElastiCache"
  period              = 960
  threshold           = var.evictions_threshold
  statistic           = "Average"
  alarm_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  ok_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_currconnections" {
  count = var.enable_currconnections_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-currconnections-${var.cache_cluster_id}"
  alarm_description   = "CurrConnections for ${var.cache_cluster_id} have been greater than 40000 for at least 5 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CurrConnections"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = var.current_connections_threshold
  statistic           = "Average"
  alarm_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  ok_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}

resource "aws_cloudwatch_metric_alarm" "elasticache_cloudwatch_alarm_swap" {
  count = var.enable_swap_alarm ? 1 : 0
  alarm_name          = "elasticache-alarm-swap-${var.cache_cluster_id}"
  alarm_description   = "Swap usage for ${var.cache_cluster_id} have been greater than 1GB for at least 10 minutes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "SwapUsage"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = var.swap_threshold
  statistic           = "Average"
  alarm_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  ok_actions = [
    module.notify_slack.slack_topic_arn,
  ]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
}