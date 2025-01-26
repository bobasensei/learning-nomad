job "identity-file" {
  datacenters = ["dc1"]
  type        = "batch"

  group "busybox" {
    count = 1
    task "busybox" {
      driver = "docker"
      
      config {
        image = "busybox"
	command = "cat"
	args = ["${NOMAD_SECRETS_DIR}/nomad_token"]
      }

      identity {
        # Expose Workload Identity in ${NOMAD_SECRETS_DIR}/nomad_token file
        file = true
      }

      resources {
        cpu    = 250
        memory = 512
      }

    }
  }
}


