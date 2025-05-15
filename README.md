<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_zstack"></a> [zstack](#requirement\_zstack) | 1.0.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redis_image"></a> [redis\_image](#module\_redis\_image) |  | n/a |
| <a name="module_redis_instance"></a> [redis\_instance](#module\_redis\_instance) |  | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [terraform_data.check_host](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.configure_redis_primary](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.configure_redis_standalone](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Specify the deployment architecture, select from standalone or replication. | `string` | `"replication"` | no |
| <a name="input_backup_storage_name"></a> [backup\_storage\_name](#input\_backup\_storage\_name) | Name of the backup storage to use | `string` | `"bs"` | no |
| <a name="input_expunge"></a> [expunge](#input\_expunge) | n/a | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name for the log server image | `string` | `"redis-by-terraform"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | URL to download the image from | `string` | `"http://minio.zstack.io:9000/packer/redis-by-packer-image-compressed.qcow2"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the cas server instance | `string` | `"redis"` | no |
| <a name="input_instance_offering_name"></a> [instance\_offering\_name](#input\_instance\_offering\_name) | Name of the instance offering to use | `string` | `"min"` | no |
| <a name="input_l3_network_name"></a> [l3\_network\_name](#input\_l3\_network\_name) | Name of the L3 network to use | `string` | `"test"` | no |
| <a name="input_non_production"></a> [non\_production](#input\_non\_production) | Whether to run in non-production mode | `bool` | `true` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | SSH password for remote access | `string` | `"zstack.redis.password"` | no |
| <a name="input_ssh_password"></a> [ssh\_password](#input\_ssh\_password) | SSH password for remote access | `string` | `"ZStack@123"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH username for remote access | `string` | `"zstack"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_node_ips"></a> [all\_node\_ips](#output\_all\_node\_ips) | 所有Redis节点IP地址 |
| <a name="output_deployment_mode"></a> [deployment\_mode](#output\_deployment\_mode) | Redis部署模式 (standalone 或 replication) |
| <a name="output_ports"></a> [ports](#output\_ports) | n/a |
| <a name="output_redis_primary_ip"></a> [redis\_primary\_ip](#output\_redis\_primary\_ip) | Redis主节点IP地址 |
| <a name="output_redis_replica_ips"></a> [redis\_replica\_ips](#output\_redis\_replica\_ips) | Redis从节点IP地址列表 |
<!-- END_TF_DOCS -->