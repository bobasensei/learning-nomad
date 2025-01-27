job "identity-file" {
  datacenters = ["dc1"]
  type        = "batch"
  group "busybox" {
    count = 1
    task "busybox" {
      driver = "docker"
      config {
        image = "busybox"
        # use this to see the available secrets
        #command = "ls"
        #args = ["${NOMAD_SECRETS_DIR}"]
	command = "cat"
	# this gets the default identity
	args = ["${NOMAD_SECRETS_DIR}/nomad_token"]
	# this gets an identity with name "bobasensei"
	#args = ["${NOMAD_SECRETS_DIR}/nomad_bobasensei.jwt"]
      }
      identity {
        # Expose Workload Identity in ${NOMAD_SECRETS_DIR}/nomad_token file
        file = true
 	env = true
        change_mode = "restart"
	# this defines a named identity, and a ttl is required
        #name = "bobasensei"
	# ttl is required for named identities
        #ttl         = "1h"
	# configured audiences are ignored for default identities
        #aud         = ["bobadojo.io"]
      }
      resources {
        cpu    = 250
        memory = 512
      }
    }
  }
}
