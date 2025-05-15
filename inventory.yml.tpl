all:
  children:
    redis:
      children:
        primary:
          hosts:
            redis-primary:
              ansible_host: ${primary_ip}
              ansible_user: ${ssh_user}
              ansible_password: ${ssh_password}
              ansible_sudo_pass: ${ssh_password}
        replicas:
          hosts:
%{ for idx, ip in replica_ips ~}
            redis-replica${idx + 1}:
              ansible_host: ${ip}
              ansible_user: ${ssh_user}
              ansible_password: ${ssh_password}
              ansible_sudo_pass: ${ssh_password}
%{ endfor ~}
    sentinel:
      hosts:
%{ for idx, ip in sentinel_ips ~}
        sentinel${idx + 1}:
          ansible_host: ${ip}
          sentinel_port: 5666
          ansible_user: ${ssh_user}
          ansible_password: ${ssh_password}
          ansible_sudo_pass: ${ssh_password}
%{ endfor ~}
  vars:
    redis_password: ${redis_password}
    redis_port: 6379
    ansible_connection: ssh
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
