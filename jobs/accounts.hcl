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
      port "http" {}
    }
    service {
      name = "accounts"
      provider = "nomad"
      port = "http"
    }
    volume "accounts-config" {
      type      = "host"
      read_only = false
      source    = "accounts-config"
    }
    task "accounts" {
      driver = "docker"
      config {
        image = "ghcr.io/bobasensei/accounts-server"
        ports = ["http"]
        command = "accounts-server"
        args = [
	  "--issuer",
          "https://accounts.timbx.me",
	  "--port",
          "${NOMAD_PORT_http}",
        ]
      }
      volume_mount {
        volume = "accounts-config"
        destination = "/config"
        read_only = false
      }
    }
  }
}

