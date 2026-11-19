# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "570853c192239ffbbadacd7a11b63e36ffbe9bfe7e7e035908d9d5d6041ea184"
resource "docker_container" "reczny" {
  attach                                      = null
  cgroup_parent                               = null
  cgroupns_mode                               = null
  command                                     = ["nginx", "-g", "daemon off;"]
  container_read_refresh_timeout_milliseconds = null
  cpu_period                                  = null
  cpu_quota                                   = null
  cpu_set                                     = null
  cpu_shares                                  = 0
  cpus                                        = null
  destroy_grace_seconds                       = null
  dns                                         = []
  dns_opts                                    = []
  dns_search                                  = []
  domainname                                  = null
  entrypoint                                  = ["/docker-entrypoint.sh"]
  gpus                                        = null
  group_add                                   = []
  hostname                                    = "570853c19223"
  image                                       = "nginx:latest"
  init                                        = false
  ipc_mode                                    = "private"
  log_driver                                  = "json-file"
  log_opts                                    = {}
  logs                                        = null
  max_retry_count                             = 0
  memory                                      = 0
  memory_reservation                          = 0
  memory_swap                                 = 0
  must_run                                    = null
  name                                        = "reczny-nginx-zmiana"
  network_mode                                = "bridge"
  pid_mode                                    = null
  privileged                                  = false
  publish_all_ports                           = false
  read_only                                   = false
  remove_volumes                              = null
  restart                                     = "no"
  rm                                          = false
  runtime                                     = "runc"
  security_opts                               = []
  shm_size                                    = 64
  start                                       = null
  stdin_open                                  = false
  stop_signal                                 = "SIGQUIT"
  stop_timeout                                = 0
  storage_opts                                = {}
  sysctls                                     = {}
  tmpfs                                       = {}
  tty                                         = false
  user                                        = null
  userns_mode                                 = null
  wait                                        = null
  wait_timeout                                = null
  working_dir                                 = null
  ports {
    external = 8110
    internal = 80
    ip       = "0.0.0.0"
    protocol = "tcp"
  }
  ports {
    external = 8110
    internal = 80
    ip       = "::"
    protocol = "tcp"
  }
}
