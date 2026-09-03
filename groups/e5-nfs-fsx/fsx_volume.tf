resource "aws_fsx_ontap_volume" "e5_nfs_vol_01" {
  name                       = "e5_nfs_vol_01"
  junction_path              = "/e5_nfs_vol_01"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.e5_nfs_svm.id

  tiering_policy {
    name           = "NONE"
  }

  lifecycle {
    ignore_changes = [
      size_in_megabytes,
      junction_path
    ]
  }
}
