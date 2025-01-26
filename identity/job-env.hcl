job "identity-env" {
  datacenters = ["dc1"]
  type        = "batch"

  group "busybox" {
    count = 1
    task "busybox" {
      driver = "docker"
      
      config {
        image = "busybox"
        command = "printenv"
        args = ["NOMAD_TOKEN"]
      }

      identity {
        # Expose Workload Identity in NOMAD_TOKEN env var
        env = true
      }

      resources {
        cpu    = 250
        memory = 512
      }

    }
  }
}


