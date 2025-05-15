# modules/zstack-image/variables.tf


variable "image_name" {
  type = string
}

variable "image_url" {
  type    = string
  default = ""
}

variable "guest_os_type" {
  type    = string
  default = ""
}

variable "platform" {
  type    = string
  default = ""
}

variable "format" {
  type    = string
  default = ""
}

variable "architecture" {
  type    = string
  default = ""
}

variable "backup_storage_name" {
  type    = string
  default = ""
}

variable "create_image" {
  type    = bool
  default = false
}

variable "expunge" {
  type  = bool
  default = true
}
