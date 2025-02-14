job "animals-server" {
  datacenters = ["dc1"]
  type = "service"
  group "animals-server" {
    count = 1
    network {
      port "http" { to = 8080 }
    }
    service {
      name = "animals-server"
      provider = "nomad"
      port = "http"
    }
    task "animals-server" {
      driver = "docker"
      config {
        image = "ghcr.io/bobasensei/animals-server:latest"
        ports = ["http"]
      }
    }
  }
}
