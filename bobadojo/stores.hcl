job "stores-server" {
  datacenters = ["dc1"]
  type = "service"

  group "stores-server" {
    count = 1
    task "stores-server" {
      driver = "docker"
      config {
        image = "ghcr.io/bobadojo/stores-server:latest"
        port_map {
          http = 8080
        }
      }

      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "stores-server"
        provider = "nomad"
	tags = [
		"urlprefix-/" 
	]
        port = "http"
      }
    }
  }
}
