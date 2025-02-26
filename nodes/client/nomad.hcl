# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

# Full configuration options can be found at https://developer.hashicorp.com/nomad/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  enabled          = false
  bootstrap_expect = 1
  server_join {
    retry_join = ["192.168.86.214:4648"]
  }
  heartbeat_grace = "1m"
}

client {
  enabled = true
  server_join {
    retry_join = ["192.168.86.214:4647"]
  }
}
