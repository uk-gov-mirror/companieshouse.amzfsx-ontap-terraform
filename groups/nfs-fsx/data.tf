data "aws_subnets" "storage_subnets" {
  filter {
    name   = "tag:Name"
    values = ["sub-storage-*"]
  }
}

data "aws_subnet" "storage_subnet" {
  for_each = toset(data.aws_subnets.storage_subnets.ids)
  id       = each.value
}

data "aws_subnet" "subnet_storage_a" {
  filter {
    name   = "tag:Name"
    values = ["sub-storage-a"]
  }
}

data "aws_subnet" "subnet_storage_b" {
  filter {
    name   = "tag:Name"
    values = ["sub-storage-b"]
  }
}

data "aws_subnet" "subnet_storage_c" {
  filter {
    name   = "tag:Name"
    values = ["sub-storage-c"]
  }
}

data "aws_subnets" "application_subnets" {
  filter {
    name   = "tag:Name"
    values = ["sub-application-*"]
  }
}

data "aws_subnet" "application_subnet" {
  for_each = toset(data.aws_subnets.application_subnets.ids)
  id       = each.value
}

data "aws_vpc" "heritage" {
  filter {
    name   = "tag:Name"
    values = ["vpc-heritage-${var.environment}"]
  }
}

data "aws_route53_zone" "private_zone" {
  name         = local.internal_fqdn
  private_zone = true
}

data "aws_ec2_managed_prefix_list" "administration_cidr_ranges" {
  name = "administration-cidr-ranges"
}

data "aws_ec2_managed_prefix_list" "shared_services_management_cidrs" {
  name = "shared-services-management-cidrs"
}

data "vault_kv_secret_v2" "nfs_fsx_credentials" {
  mount = "team-unix-storage"
  name  = "${var.aws_account}/amzfsx/nfs-fsx/credentials"
}

data "vault_generic_secret" "netapp_account_id" {
  path = "applications/shared-services-eu-west-2/netapp/account"
}

data "vault_generic_secret" "netapp_fsx_account_id" {
  path = "applications/shared-services-eu-west-2/netapp/fsx/"
}
