job "accounts" {
  datacenters = ["dc1"]
  type = "service"
  affinity {
    attribute = "${attr.cpu.arch}"
    value     = "amd64"
    weight    = 100
  }
  group "accounts" {
    count = 1
    network {
      port "http" { to = 9998 }
    }
    service {
      name = "accounts"
      provider = "nomad"
      port  = "http"
    }
    volume "accounts-config" {
      type      = "host"
      read_only = false
      source    = "accounts-config"
    }
    task "accounts" {
      driver = "docker"
      config {
        #image = "ghcr.io/bobasensei/accounts-server"
        image = "timburks/accounts-server:latest"
        ports = ["http"]
        command = "accounts-server"
      }
      volume_mount {
        volume = "accounts-config"
        destination = "/config"
        read_only = false
      }
    }
  }
}

