# modules/zstack-image/main.tf

# 查询镜像存储服务器
data "zstack_backupstorages" "image_store" {
  name  = var.backup_storage_name
}

# 如果 create_image 为 true，创建镜像
resource "zstack_image" "image" {
  count = var.create_image ? 1 : 0

  name        = var.image_name
  description = "Created by Terraform module"
  url         = var.image_url
  guest_os_type = var.guest_os_type
  platform    = var.platform
  format      = var.format
  architecture = var.architecture
  backup_storage_uuids = [data.zstack_backupstorages.image_store.backup_storages.0.uuid]
  boot_mode = "Legacy"
  expunge = var.expunge
}

# 如果 create_image 为 false，查询已有镜像
data "zstack_images" "existing_image" {
  count = var.create_image ? 0 : 1
  name = var.image_name
}

# 输出镜像 UUID
locals {
  image_uuid = var.create_image ? zstack_image.image[0].uuid : data.zstack_images.existing_image[0].images[0].uuid
}
