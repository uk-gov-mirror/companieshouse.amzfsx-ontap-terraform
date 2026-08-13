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
  #default     = ""
}

variable "repo" {
  description = "Github Repository where code resides"
  type        = string
  default     = "amzfsx-ontap-terraform"
}

variable "service" {
  type        = string
  description = "The service name to be used when creating AWS resources."
  default     = "NFS"
}

variable "service_subtype" {
  type        = string
  description = "The service subtype name to be used when creating AWS resources."
  default     = "FSx"
}

variable "team" {
  type        = string
  description = "The team name for ownership of this service."
  default     = "Linux and Storage Support"
}

variable "fsx_fs_name" {
  type        = string
  description = "The service name to be used when creating AWS resources."
  #default     = ""
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

variable "fsx_fs_mgmt_dns_name" {
  type        = string
  description = "The dns name for the FSx filesystem management address"
  default     = false
}

variable "fsx_fs_nfs_dns_name" {
  type        = string
  description = "The dns name for the FSx filesystem NFS address"
  default     = false
}

variable "nfs_ports" {
  type        = list(any)
  description = "A list of ports and protocols used for NFS client access"
  default = [
    { "protocol" = "tcp", "port" = 111 },
    { "protocol" = "udp", "port" = 111 },
    { "protocol" = "tcp", "port" = 635 },
    { "protocol" = "udp", "port" = 635 },
    { "protocol" = "tcp", "port" = 2049 },
    { "protocol" = "udp", "port" = 2049 },
    { "protocol" = "tcp", "port" = 4045, "to_port" = 4046 },
    { "protocol" = "udp", "port" = 4045, "to_port" = 4046 },
    { "protocol" = "udp", "port" = 4049 }
  ]
}

variable "cifs_ports" {
  type        = list(any)
  description = "A list of ports and protocols used for CIFS client access"
  default = [
    { "protocol" = "tcp", "port" = 135 },
    { "protocol" = "udp", "port" = 135 },
    { "protocol" = "tcp", "port" = 139 },
    { "protocol" = "udp", "port" = 139 },
    { "protocol" = "tcp", "port" = 445 },
    { "protocol" = "udp", "port" = 137 }
  ]
}