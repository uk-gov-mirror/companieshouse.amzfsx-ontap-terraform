locals {
  common_resource_name  = "${var.environment}-${var.fsx_fs_name}"
  fsx_admin_password    = data.vault_kv_secret_v2.nfs_fsx_credentials.data["fsxadmin_password"]
  netapp_account_id     = data.vault_generic_secret.netapp_account_id.data["account-id"]
  netapp_fsx_account_id = data.vault_generic_secret.netapp_fsx_account_id.data["account-id"]

  storage_subnet_a_id = data.aws_subnet.subnet_storage_a.id
  storage_subnet_b_id = data.aws_subnet.subnet_storage_b.id
  storage_subnet_c_id = data.aws_subnet.subnet_storage_c.id
  preferred_subnet_id = local.storage_subnet_a_id

  storage_subnets = can(regex("MULTI", var.fsx_deployment_type)) ? [local.storage_subnet_a_id, local.storage_subnet_b_id] : [local.preferred_subnet_id]

  internal_fqdn = format("%s.%s.aws.internal", split("-", var.aws_account)[1], split("-", var.aws_account)[0])

  default_tags = {
    # Tags
    Name           = local.common_resource_name
    Repository     = var.repo
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = "Linux and Storage Support"
  }

  application_cidr_blocks = [for subnet in data.aws_subnet.application_subnet : subnet.cidr_block]
  nfs_cidr_blocks         = concat(local.application_cidr_blocks)
  nfs_ingress_cidrs       = length(local.nfs_cidr_blocks) >= 1 ? setproduct(local.nfs_cidr_blocks, var.nfs_ports) : []

}
