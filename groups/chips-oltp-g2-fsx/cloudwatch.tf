resource "aws_cloudwatch_metric_alarm" "fsx_percent_used_capacity" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-percent-used-capacity"
  alarm_description = "Alarm when FSx percent used capacity exceeds the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "StorageCapacityUtilization"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id,
    StorageTier  = "SSD",
    DataType     = "All",
    Aggregate    = "aggr1"
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "fsx_fsnetwork_throughput" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-fsnetwork-throughput"
  alarm_description = "Alarm when FSx network throughput goes above the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "NetworkThroughput"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "fsx_fsdisk_throughput" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-fsdisk-throughput"
  alarm_description = "Alarm when FSx fileserver disk throughput goes above the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "FileServerDiskThroughputUtilization"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "fsx_fsdisk_iops" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-fsdisk-iops"
  alarm_description = "Alarm when FSx fileserver disk IOPS goes above the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "FileServerDiskIopsUtilization"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "fsx_fscpu_utilization" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-fscpu-utilization"
  alarm_description = "Alarm when FSx fileserver CPU utilization goes above the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "CPUUtilization"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "fsx_disk_iops_utilization" {
  count = var.monitoring ? 1 : 0

  alarm_name        = "${local.common_resource_name}-fsx-disk-iops-utilization"
  alarm_description = "Alarm when FSx disk IOPS utilization goes above the configured threshold."
  namespace         = "AWS/FSx"
  metric_name       = "DiskIopsUtilization"
  dimensions = {
    FileSystemId = aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
  }
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 3
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  ok_actions          = [aws_sns_topic.chips_oltp_g2_fsx[0].arn]
  treat_missing_data  = "notBreaching"
}

#resource "aws_cloudwatch_dashboard" "fsx" {
#  count = var.monitoring ? 1 : 0
#  dashboard_name = "${local.common_resource_name}-dashboard"
#  dashboard_body = jsonencode({
#    widgets = [
#      {
#        type       = "metric"
#        x          = 0
#        y          = 0
#        width      = 24
#        height     = 6
#        properties = {
#          view   = "timeSeries"
#          title  = "FSx Percent Used Capacity"
#          metrics = [
#                      [
#                        "AWS/FSx",
#                        "PercentUsedCapacity",
#                        "FileSystemId", 
#                        aws_fsx_ontap_file_system.chips_oltp_g2_fsx.id
#                      ]
#                    ]
#          stat   = "Average"
#          period = 300
#          region = var.aws_region
#          yAxis  = { left = { min = 0, max = 100 } }
#        }
#      }
#    ]
#  })
#}
