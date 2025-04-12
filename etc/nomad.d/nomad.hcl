# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

# Full configuration options can be found at https://developer.hashicorp.com/nomad/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  enabled          = true
  bootstrap_expect = 1
  heartbeat_grace  = "1m"
}

client {
  enabled = true
  servers = ["127.0.0.1"]

  host_volume "accounts-config" {
    path = "/srv/nomad/accounts/config"
    read_only = false
  }

  host_volume "pds" {
    path = "/srv/nomad/pds"
    read_only = false
  }
}
