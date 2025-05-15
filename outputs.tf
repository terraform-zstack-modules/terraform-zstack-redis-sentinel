

# 输出Redis集群信息
output "redis_primary_ip" {
  value = local.primary_ip
  description = "Redis主节点IP地址"
}

output "redis_replica_ips" {
  value = local.replica_ips
  description = "Redis从节点IP地址列表"
}

output "all_node_ips" {
  value = local.node_ips
  description = "所有Redis节点IP地址"
}

output "deployment_mode" {
  value = var.architecture
  description = "Redis部署模式 (standalone 或 replication)"
}

output "ports" {
  value = {
    redis_port = "6379"
    sentinel_port = "5666"
  }
}
