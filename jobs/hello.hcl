job "hello" {
  datacenters = ["dc1"]
  type = "service"
  affinity {
    attribute = "${attr.cpu.arch}"
    value     = "amd64"
    weight    = 100
  }
  group "hello" {
    count = 1
    network {
      port "http" {}
    }
    service {
      name = "hello"
      provider = "nomad"
      port = "http"
    }
    task "hello" {
      driver = "docker"
      config {
	# this uses host networking to see the local /etc/hosts
	# which it needs to resolve the issuer in isolated (test)
	# environments
        network_mode = "host"
        image = "ghcr.io/bobasensei/hello-server"
        ports = ["http"]
      }
      env {
        CLIENT_ID = "web"
        CLIENT_SECRET = "secret"
        ISSUER = "https://accounts.timbx.me"
        SCOPES = "openid profile"
        PORT = "${NOMAD_PORT_http}"
      }
    }
  }
}
