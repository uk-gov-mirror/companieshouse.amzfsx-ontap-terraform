variable "aws_account" {
  type        = string
  description = "The name of the AWS account in which resources will be provisioned."
}

variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be created."
}

variable "environment" {
  type        = string
  description = "The environment name to be used when provisioning AWS resources."
}

variable "repo" {
  description = "Github Repository where code resides"
  type        = string
  default     = ""
}

variable "service" {
  type        = string
  description = "The service name to be used when creating AWS resources."
  default     = ""
}

variable "service_subtype" {
  type        = string
  description = "The service subtype name to be used when creating AWS resources."
  default     = ""
}

variable "team" {
  type        = string
  description = "The team name for ownership of this service."
  default     = "Linux and Storage Support"
}

variable "fsx_fs_name" {
  type        = string
  description = "The service name to be used when creating AWS resources."
}

variable "fsx_storage_capacity" {
  type        = number
  description = "The storage capacity (GiB) of the file system"
}

variable "fsx_deployment_type" {
  type        = string
  description = "The filesystem deployment type. Supports MULTI_AZ_1, MULTI_AZ_2, SINGLE_AZ_1, and SINGLE_AZ_2"
}

variable "fsx_throughput_capacity" {
  type        = number
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are 128, 256, 512, 1024, 2048, and 4096"
}

variable "fsx_auto_backup_retention" {
  type        = number
  description = "The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days."
  default     = "0"
}

variable "vpc_id" {
  description = "VPC ID for Lambda-link function"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for Lambda-link function"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs for Lambda-link function"
  type        = list(string)
  default     = []
}

variable "fsx_fs_mgmt_dns_name" {
  type        = string
  description = "The dns name for the FSx filesystem management address"
  default     = false
}

variable "fsx_fs_mgmt_dns_record" {
  type        = string
  description = "The dns record used for the FSx filesystem mamnagement address"
  default     = false
}

variable "e5_fin_data_size" {
  type        = number
  description = "Volume Size in Mb"
  default     = "1"
}

variable "e5_fin_fra_size" {
  type        = number
  description = "Volume Size in Mb"
  default     = "1"
}

variable "e5_fin_redo_size" {
  type        = number
  description = "Volume Size in Mb"
  default     = "1"
}

variable "e5_fin_data_count" {
  type        = number
  description = "Volume Count"
  default     = "0"
}

variable "e5_fin_fra_count" {
  type        = number
  description = "Volume Count"
  default     = "0"
}

variable "e5_fin_redo_count" {
  type        = number
  description = "Volume Count"
  default     = "0"
}

variable "create_data_volumes" {
  description = "Boolean to enable/disable volume creation"
  default     = false
  type        = bool
}

variable "create_fra_volumes" {
  description = "Boolean to enable/disable volume creation"
  default     = false
  type        = bool
}

variable "create_redo_volumes" {
  description = "Boolean to enable/disable volume creation"
  default     = false
  type        = bool
}

variable "monitoring" {
  description = "Boolean to enable/disable monitoring"
  default     = false
  type        = bool
}