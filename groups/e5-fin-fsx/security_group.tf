### Ingress Rules

resource "aws_security_group" "e5_fin_fsx" {
  name        = local.common_resource_name
  description = "Security group for the ${var.fsx_fs_name}"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "fsx_ssh_https" {
  description       = "Allow SSH and HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  ip_protocol       = "tcp"
  for_each          = toset(["22", "443"])
  from_port         = each.value
  to_port           = each.value
}

resource "aws_vpc_security_group_ingress_rule" "fsx_ssh" {
  count             = length(data.aws_subnets.storage_subnets.ids)
  description       = "Allow SSH connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "fsx_https" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "fsx_app_https" {
  count = length(data.aws_subnets.application_subnets.ids)

  description       = "Allow HTTPS connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.application_subnet)[count.index].cidr_block
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "fsx_iscsi" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow ISCSI connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 3260
  to_port           = 3260
}

resource "aws_vpc_security_group_ingress_rule" "fsx_iscsi_data" {
  count = length(data.aws_subnets.data_subnets.ids)

  description       = "Allow ISCSI connectivity for ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.data_subnet)[count.index].cidr_block
  from_port         = 3260
  to_port           = 3260
}

resource "aws_vpc_security_group_ingress_rule" "fsx_snap_ndmp" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow SnapMirror operations ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 10000
  to_port           = 10000
}

resource "aws_vpc_security_group_ingress_rule" "fsx_snap_cluster" {
  count = length(data.aws_subnets.storage_subnets.ids)

  description       = "Allow SnapMirror operations ${var.fsx_fs_name}"
  security_group_id = aws_security_group.e5_fin_fsx.id
  ip_protocol       = "tcp"
  cidr_ipv4         = values(data.aws_subnet.storage_subnet)[count.index].cidr_block
  from_port         = 11104
  to_port           = 11105
}

### Egress Rules

resource "aws_vpc_security_group_egress_rule" "fsx_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.e5_fin_fsx.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
