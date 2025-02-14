job "httpbin" {
  datacenters = ["dc1"]
  type = "service"
  affinity {
    attribute = "${attr.cpu.arch}"
    value     = "amd64"
    weight    = 100
  }
  group "httpbin" {
    count = 1
    network {
      port "http" { to = 80 }
    }
    service {
      name = "httpbin"
      provider = "nomad"
      port = "http"
    }
    task "httpbin" {
      driver = "docker"
      config {
        image = "kennethreitz/httpbin:latest"
        ports = ["http"]
      }
    }
  }
}
