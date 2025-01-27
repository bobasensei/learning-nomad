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
	# if no args are provided, all environment vars are printed
	# this gets the default identity token
        args = ["NOMAD_TOKEN"]
	# this gets a named identity token
        #args = ["NOMAD_TOKEN_bobasensei"] 
      }
      identity {
        # Expose Workload Identity in NOMAD_TOKEN env var
        env = true
	change_mode = "restart"
	# this defines a named identity
	#name = "bobasensei"
        # ttl is required for named identities
	#ttl         = "1h"
        # configured audiences are ignored for the default identity
        #aud         = ["bobadojo.io"]
      }
      resources {
        cpu    = 250
        memory = 512
      }
    }
  }
}
