resource "aws_fsx_ontap_volume" "snapshot_data_vol" {
  count                      = var.snapshot_data_count
  name                       = "snapshot_data_vol_${format("%02d", count.index + 1)}"
  junction_path              = "/snapshot_data_vol_${format("%02d", count.index + 1)}"
  size_in_megabytes          = var.snapshot_data_size
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.snapshot_svm.id

  tiering_policy {
    name = "NONE"
  }
}
