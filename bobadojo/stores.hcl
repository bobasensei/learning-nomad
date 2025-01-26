job "stores-server" {
  datacenters = ["dc1"]
  type = "service"


  group "stores-server" {
    count = 1
    network {
      port "http" { to = 8080 }
    }
    service {
      name = "stores-server"
      provider = "nomad"
      tags = [
	"urlprefix-/" 
      ]
      port = "http"
    }
    task "stores-server" {
      driver = "docker"
      config {
        image = "ghcr.io/bobadojo/stores-server:latest"
        ports = ["http"]
      }

    }
  }
}
