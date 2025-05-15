# modules/zstack-instance/outputs.tf

output "instances" {
  description = "The created instances"
  value       = zstack_instance.instance
}

output "instance_ids" {
  description = "IDs of the created instances"
  value       = zstack_instance.instance[*].uuid
}

output "instance_names" {
  description = "Names of the created instances"
  value       = zstack_instance.instance[*].name
}

output "instance_ips" {
  description = "The IP addresses of the created instances"
  value       = [for instance in zstack_instance.instance : instance.vm_nics[0].ip]
}

output "instance_nics" {
  description = "The network interfaces of the created instances"
  value       = [for instance in zstack_instance.instance : instance.vm_nics]
}
