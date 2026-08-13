resource "aws_route53_record" "nfs_fsx_dns" {
  zone_id = data.aws_route53_zone.private_zone.id
  name    = var.fsx_fs_mgmt_dns_name
  type    = "A"
  ttl     = 300
  records = ["${tolist(aws_fsx_ontap_file_system.nfs_fsx.endpoints[0].management[0].ip_addresses)[0]}"]
}

resource "aws_route53_record" "nfs_export_fsx_dns" {
  zone_id = data.aws_route53_zone.private_zone.id
  name    = var.fsx_fs_nfs_dns_name
  type    = "A"
  ttl     = 300
  records = ["${tolist(aws_fsx_ontap_storage_virtual_machine.nfs_svm.endpoints[0].nfs[0].ip_addresses)[0]}"]
}