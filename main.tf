provider "zstack" {
  host              = var.host
  access_key_id     = var.access_key_id
  access_key_secret = var.access_key_secret
}

locals {
  # 如果是standalone模式，只创建1个节点；如果是replication模式，创建3个节点
  node_count = var.architecture == "standalone" ? 1 : 3
}

module "redis_image" {
  source = "./modules/image"

  create_image        = true
  image_name          = var.image_name
  image_url           = var.image_url
  guest_os_type      = "Centos 7"
  platform           = "Linux"
  format             = "qcow2"
  architecture       = "x86_64"
  expunge      = var.expunge
  backup_storage_name = var.backup_storage_name
}

# 创建虚拟机实例
module "redis_instance" {
  source = "./modules/instance"

  count = local.node_count
  name                  = "${var.instance_name}-${count.index + 1}"
  description           = "redis Server Created by Terraform"
  instance_count        = 1
  image_uuid            = module.redis_image.image_uuid
  l3_network_name       = var.l3_network_name
  instance_offering_name = var.instance_offering_name
  expunge      = var.expunge
}

# 获取所有节点IP地址
locals {
  node_ips = flatten([for i in range(local.node_count) : module.redis_instance[i].instance_ips])
  primary_ip = local.node_ips[0]
  replica_ips = var.architecture == "replication" ? slice(local.node_ips, 1, length(local.node_ips)) : []
  sentinel_ips = var.architecture == "replication" ? local.node_ips : []  
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
  redis_password = var.redis_password
}

resource "local_file" "inventory" {
  count = var.architecture == "replication" ? 1 : 0
  depends_on = [module.redis_instance]
  content = templatefile("${path.module}/inventory.yml.tpl", {
    primary_ip = local.primary_ip
    replica_ips = local.replica_ips
    sentinel_ips = local.sentinel_ips
    ssh_user = local.ssh_user
    ssh_password = local.ssh_password
    redis_password = local.redis_password
  })
  filename = "${path.module}/inventory.yml"
}

resource "terraform_data" "check_host" {
  count = length(local.node_ips)

  connection {
    type     = "ssh"
    user     = local.ssh_user
    password = local.ssh_password
    host     = local.node_ips[count.index]
    timeout  = "15m"
  }

  provisioner "local-exec" {
    command = "echo 'Host  is reachable' >> connection.log 2>&1"
  }
}


resource "terraform_data" "configure_redis_standalone" {
  depends_on = [module.redis_instance,terraform_data.check_host]
  
  # SSH连接配置
  connection {
    type     = "ssh"
    user     = local.ssh_user
    password = local.ssh_password
    host     = local.primary_ip
    timeout  = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Configuring Redis in standalone mode...'",
      "sudo systemctl enable redis-server",
      "sudo systemctl start redis-server",
      "redis-cli ping"  # 简单测试Redis是否运行
    ]
  }
}

resource "terraform_data" "configure_redis_primary" {
  count = var.architecture == "replication" ? 1 : 0
  depends_on = [module.redis_instance,terraform_data.check_host]
  
  # SSH连接配置
  connection {
    type     = "ssh"
    user     = local.ssh_user
    password = local.ssh_password
    host     = local.primary_ip
    timeout  = "5m"
  }

  provisioner "file" {
    source      = "${path.module}/inventory.yml"
    destination = "/home/${local.ssh_user}/inventory.yml"
    on_failure = fail
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /home/${local.ssh_user}/inventory.yml /opt/redis-ansible/inventory.yml",
      "sudo chmod 644 /opt/redis-ansible/inventory.yml",
      "cd /opt/redis-ansible",
      var.non_production ? 
        "ansible-playbook -i inventory.yml playbooks/redis-replication.yml -e 'non_production=true'" :
        "ansible-playbook -i inventory.yml playbooks/redis-replication.yml",
      var.non_production ? 
        "ansible-playbook -i inventory.yml playbooks/redis-sentinel.yml -e 'non_production=true'" :
        "ansible-playbook -i inventory.yml playbooks/redis-sentinel.yml"
    ]
  }

}