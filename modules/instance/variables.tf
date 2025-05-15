
# variables.tf

variable "name" {
  description = "The name of the instance"
  type        = string
}

variable "description" {
  description = "The description of the instance"
  type        = string
  default     = ""
}


variable "image_uuid" {
  description = "The UUID of the image to use"
  type        = string
}


variable "cluster_uuid" {
  description = "The UUID of the cluster where the instance will be created"
  type        = string
  default     = null
}

variable "hostname" {
  description = "The hostname of the instance"
  type        = string
  default     = ""
}

variable "host_uuid" {
  description = "The UUID of the host where the instance will be created"
  type        = string
  default     = null
}

variable "root_volume_type" {
  description = "The type of the root volume"
  type        = string
  default     = "DefaultPrimaryStorage"
}

variable "system_tags" {
  description = "The system tags of the instance"
  type        = list(string)
  default     = []
}

variable "user_tags" {
  description = "The user tags of the instance"
  type        = list(string)
  default     = []
}

variable "default_password" {
  description = "The default password for the instance"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_key_uuid" {
  description = "The UUID of the SSH key to use"
  type        = string
  default     = null
}

variable "primary_storage_uuid_for_root_volume" {
  description = "The UUID of the primary storage for the root volume"
  type        = string
  default     = null
}

variable "data_volumes" {
  description = "List of data volumes to attach to the instance"
  type = list(object({
    disk_offering_uuid = string
    name              = optional(string)
    description       = optional(string)
    primary_storage_uuid = optional(string)
    system_tags       = optional(list(string))
  }))
  default = []
}

variable "zone_uuid" {
  description = "The UUID of the zone where the instance will be created"
  type        = string
  default     = null
}

variable "timeout" {
  description = "Timeout for operations"
  type        = number
  default     = 300
}

# 添加到variables.tf


variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "l3_network_name" {
  description = "The name of the L3 network to query (alternative to l3_network_uuids)"
  type        = string
  default     = null
}

variable "l3_network_uuids" {
  description = "List of L3 network UUIDs to attach to the instance"
  type        = list(string)
  default     = []  # 空列表作为默认值
}

variable "instance_offering_name" {
  description = "The name of the instance offering to query (alternative to instance_offering_uuid)"
  type        = string
  default     = null
}

variable "instance_offering_uuid" {
  description = "UUID of the instance offering"
  type        = string
  default     = ""  
}

variable "never_stop" {
  description = "vm ha"
  type        = bool
  default     = true  
}

variable "expunge" {
  type  = bool
  default = true
}
