### Ingress Rules

resource "aws_security_group" "e5_nfs_fsx" {
  name        = local.common_resource_name
  description = "Security group for the ${var.fsx_fs_name}"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group" "e5_nfs_fsx_cifs" {
  name        = "FSx CIFS"
  description = "CIFS Security group for the ${var.fsx_fs_name}"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group" "e5_nfs_fsx_nfs" {
  name        = "FSx NFS"
  description = "NFS Security group for the ${var.fsx_fs_name}"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "fsx_ssh_https" {
  description       = "Allow SSH and HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  ip_protocol       = "tcp"
  for_each          = toset(["22", "443"])
  from_port         = each.value
  to_port           = each.value
}

resource "aws_vpc_security_group_ingress_rule" "fsx_ssh" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow SSH connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "fsx_https" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "fsx_ci_https" {
  description       = "Allow HTTPS connectivity between Concourse and ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  prefix_list_id    = data.aws_ec2_managed_prefix_list.shared_services_management_cidrs.id
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "fsx_app_https" {
  count = length(data.aws_subnets.application_subnets.ids)

  description       = "Allow HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.application_subnet)[count.index].cidr_block
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "fsx_nfs" {
  count = length(local.nfs_ingress_cidrs)

  security_group_id = aws_security_group.e5_nfs_fsx_nfs.id
  description       = "Allow clients to access CVO via NFS"
  from_port         = local.nfs_ingress_cidrs[count.index][1]["port"]
  to_port           = lookup(local.nfs_ingress_cidrs[count.index][1], "to_port", local.nfs_ingress_cidrs[count.index][1]["port"])
  ip_protocol       = local.nfs_ingress_cidrs[count.index][1]["protocol"]
  cidr_ipv4         = local.nfs_ingress_cidrs[count.index][0]
}

resource "aws_vpc_security_group_ingress_rule" "fsx_cifs" {
  for_each          = { for rule in var.cifs_ports : join("_", [rule.protocol, rule.port]) => rule if length(data.aws_ec2_managed_prefix_list.administration_cidr_ranges) > 0 }
  security_group_id = aws_security_group.e5_nfs_fsx_cifs.id
  description       = "Allow clients to access via CIFS"
  ip_protocol       = each.value.protocol
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  from_port         = each.value.port
  to_port           = lookup(each.value, "to_port", each.value.port)
}
resource "aws_vpc_security_group_ingress_rule" "fsx_snap_ndmp" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow SnapMirror operations ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 10000
  to_port           = 10000
}

resource "aws_vpc_security_group_ingress_rule" "fsx_snap_cluster" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow SnapMirror operations ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 11104
  to_port           = 11105
}

### Egress Rules

resource "aws_vpc_security_group_egress_rule" "fsx_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.e5_nfs_fsx.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}