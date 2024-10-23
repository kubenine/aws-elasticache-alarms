# ElastiCache Monitoring with Terraform

This project sets up CloudWatch alarms for an AWS ElastiCache cluster using Terraform. It monitors various metrics and sends notifications to a Slack channel when thresholds are exceeded.


## Prerequisites

- Terraform installed (version compatible with AWS provider ~> 5.0)
- AWS CLI configured with appropriate credentials
- Slack webhook URL for notifications

## Configuration

1. Clone this repository
2. Update the `terraform.tfvars` file with your specific values:


## Supported Alerts

This configuration sets up the following CloudWatch alarms for your ElastiCache cluster:

1. **CPU Utilization (90% threshold)**
   - **Metric**: CPUUtilization
   - **Description**: Alerts when the CPU utilization of the ElastiCache cluster reaches 90% of the available CPU capacity.
   - **Purpose**: Helps identify when the cluster is under high CPU load, which may indicate the need for scaling or optimization.

2. **Swap Usage**
   - **Metric**: SwapUsage
   - **Description**: Monitors the amount of swap space being used by the ElastiCache cluster.
   - **Purpose**: High swap usage can indicate memory pressure and potential performance issues.

3. **Evictions**
   - **Metric**: Evictions
   - **Description**: Tracks the number of keys that have been evicted from the cache due to memory constraints.
   - **Purpose**: High eviction rates may indicate that the cache is under memory pressure and may need to be scaled up.

4. **Current Connections**
   - **Metric**: CurrConnections
   - **Description**: Monitors the number of client connections to the ElastiCache cluster.
   - **Purpose**: Helps track the usage patterns of the cache and can indicate if connection limits are being approached.

5. **Replication Lag**
   - **Metric**: ReplicationLag
   - **Description**: Measures the delay between updates on the primary node and when they are applied on the replica nodes.
   - **Purpose**: High replication lag can impact data consistency across nodes and overall cluster performance.

6. **Redis Engine CPU Utilization**
   - **Metric**: EngineCPUUtilization
   - **Description**: Monitors the percentage of CPU utilization by the Redis engine itself.
   - **Purpose**: Helps distinguish between overall system CPU usage and CPU usage specific to Redis operations.

Each of these alarms is configured to send notifications to the specified Slack channel when thresholds are exceeded, allowing for prompt investigation and action when potential issues arise.

## Prerequisites

- Terraform installed (version compatible with AWS provider ~> 5.0)
- AWS CLI configured with appropriate credentials
- Slack webhook URL for notifications

## Configuration

1. Clone this repository
2. Update the `terraform.tfvars` file with your specific values:


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_notify_slack"></a> [notify\_slack](#module\_notify\_slack) | terraform-aws-modules/notify-slack/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_currconnections](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_engine_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_evictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_high_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_replication_lag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_cloudwatch_alarm_swap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_cluster_id"></a> [cache\_cluster\_id](#input\_cache\_cluster\_id) | Elasticache cluster ID | `any` | n/a | yes |
| <a name="input_cpu_percent_threshold"></a> [cpu\_percent\_threshold](#input\_cpu\_percent\_threshold) | Threshold for cpu alarm in % | `number` | `90` | no |
| <a name="input_current_connections_threshold"></a> [current\_connections\_threshold](#input\_current\_connections\_threshold) | Threshold for current connections alarm | `number` | `1000` | no |
| <a name="input_enable_currconnections_alarm"></a> [enable\_currconnections\_alarm](#input\_enable\_currconnections\_alarm) | Enable or disable the current connections alarm | `bool` | `true` | no |
| <a name="input_enable_engine_cpu_alarm"></a> [enable\_engine\_cpu\_alarm](#input\_enable\_engine\_cpu\_alarm) | Enable or disable the Redis engine CPU utilization alarm | `bool` | `true` | no |
| <a name="input_enable_evictions_alarm"></a> [enable\_evictions\_alarm](#input\_enable\_evictions\_alarm) | Enable or disable the evictions alarm | `bool` | `true` | no |
| <a name="input_enable_high_cpu_alarm"></a> [enable\_high\_cpu\_alarm](#input\_enable\_high\_cpu\_alarm) | Enable or disable the high CPU utilization alarm | `bool` | `true` | no |
| <a name="input_enable_replication_lag_alarm"></a> [enable\_replication\_lag\_alarm](#input\_enable\_replication\_lag\_alarm) | Enable or disable the replication lag alarm | `bool` | `true` | no |
| <a name="input_enable_swap_alarm"></a> [enable\_swap\_alarm](#input\_enable\_swap\_alarm) | Enable or disable the swap usage alarm | `bool` | `true` | no |
| <a name="input_engine_cpu_percent_threshold"></a> [engine\_cpu\_percent\_threshold](#input\_engine\_cpu\_percent\_threshold) | Threshold for Redis engine CPU utilization alarm in % | `number` | `80` | no |
| <a name="input_evictions_threshold"></a> [evictions\_threshold](#input\_evictions\_threshold) | Threshold for evictions alarm | `string` | `"0"` | no |
| <a name="input_low_cpu_percent_threshold"></a> [low\_cpu\_percent\_threshold](#input\_low\_cpu\_percent\_threshold) | Threshold for low CPU utilization alarm in % | `number` | `10` | no |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | `"us-east-1"` | no |
| <a name="input_replication_lag_threshold"></a> [replication\_lag\_threshold](#input\_replication\_lag\_threshold) | elasticache-alarm-replication-lag | `number` | `100` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | Slack channel for notifications | `string` | `"airflow-notifications"` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | Slack username for notifications | `string` | `"reporter"` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Slack webhook URL | `string` | n/a | yes |
| <a name="input_swap_threshold"></a> [swap\_threshold](#input\_swap\_threshold) | Threshold for swap alarm | `number` | `262144000` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->


## Slack Notifications

This module integrates with Slack to send notifications when CloudWatch alarms are triggered. It uses the [`terraform-aws-modules/notify-slack/aws`](https://github.com/terraform-aws-modules/terraform-aws-notify-slack) module internally.

### How It Works

- **Integration**: The module includes the Slack notification module as a submodule.
- **SNS Topic**: A new SNS topic is created specifically for Slack notifications.
- **CloudWatch Alarms**: Alarms created by this module are configured to send notifications to the SNS topic.
- **Slack Messages**: When an alarm is triggered, a message is sent to the specified Slack channel via the webhook URL.

### Configuration

To enable Slack notifications, you need to provide some Slack-specific variables when using the module.

#### **Required Variables**

- **`slack_webhook_url`**: The Slack Incoming Webhook URL used to send messages to your Slack workspace.
- **`slack_channel`**: *(Optional)* The Slack channel where notifications will be sent. If not provided, it defaults to the channel configured in the webhook.
- **`slack_username`**: *(Optional)* The username that will appear as the sender of the Slack messages. Defaults to `"reporter"`.

#### **Steps to Set Up Slack Notifications**

1. **Create a Slack App and Webhook**

   - Navigate to [Slack API: Applications](https://api.slack.com/apps).
   - Click **Create New App**.
   - Choose **From scratch** and provide an app name and workspace.
   - Under **Features**, select **Incoming Webhooks**.
   - Activate **Incoming Webhooks**.
   - Click **Add New Webhook to Workspace**.
   - Select the channel where you want to receive notifications and authorize.
   - Copy the **Webhook URL** provided.

2. **Configure the Module with Slack Variables**

   Include the `slack_webhook_url` and optionally `slack_channel` and `slack_username` in your module configuration:

   ```hcl
   module "elasticache_alarms" {
     source = "github.com/yourusername/aws-elasticache-alarms"

     # ... other required variables ...

     slack_webhook_url = "https://hooks.slack.com/services/your/webhook/url"
     slack_channel     = "alerts"
     slack_username    = "AlertBot"
   }

### Integration with `terraform-aws-modules/notify-slack/aws`

This module internally uses the [`terraform-aws-modules/notify-slack/aws`](https://github.com/terraform-aws-modules/terraform-aws-notify-slack) module to handle Slack notifications.

#### **Module Configuration in `main.tf`**

```hcl
module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 5.0"

  sns_topic_name    = "elasticache-slack-${var.cache_cluster_id}"
  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username
}
```

## How It Works Within the Module

#### SNS Topic Creation: 
he `notify_slack` module creates an SNS topic that subscribes to your Slack webhook.

#### Alarm Actions
All CloudWatch alarms created by this module have their `alarm_actions` and `ok_actions` set to the SNS topic ARN provided by the `notify_slack` module.

#### Message Delivery
When an alarm changes state (e.g., from `OK` to `ALARM`), it publishes a message to the SNS topic, which then triggers a notification to Slack.
