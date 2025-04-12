job "pds" {
  datacenters = ["dc1"]
  type = "service"
  affinity {
    attribute = "${attr.cpu.arch}"
    value     = "amd64"
    weight    = 100
  }
  group "pds" {
    count = 1
    network {
      port "http" { to = 3000 }
    }
    service {
      name = "pds"
      provider = "nomad"
      port  = "http"
    }
    volume "pds" {
      type      = "host"
      read_only = false
      source    = "pds"
    }
    task "pds" {
      driver = "docker"
      config {
	image = "ghcr.io/bluesky-social/pds:0.4"
        ports = ["http"]
#        command = "pds-server"
      }
      volume_mount {
        volume = "pds"
        destination = "/pds"
        read_only = false
      }
      env {
        TZ="PDT"
        PDS_HOSTNAME="bsky.timbx.me"
        PDS_JWT_SECRET="dc0b6d957198088f4ece3c4fc648d4fb"
        PDS_ADMIN_PASSWORD="avengersassemble"
        PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX="2063d7bca6b719511082690caa520338e107fd5bc09d02a858b6dabb38422131"
        PDS_DATA_DIRECTORY="/pds"
        PDS_BLOBSTORE_DISK_LOCATION="/pds/blocks"
        PDS_BLOBSTORE_DISK_TMP_LOCATION="/pds/temp"
        PDS_BLOB_UPLOAD_LIMIT="52428800"
        PDS_DID_PLC_URL="https://plc.directory"
        PDS_BSKY_APP_VIEW_URL="https://api.bsky.app"
        PDS_BSKY_APP_VIEW_DID="did:web:api.bsky.app"
        PDS_REPORT_SERVICE_URL="https://mod.bsky.app"
        PDS_REPORT_SERVICE_DID="did:plc:ar7c4by46qjdydhdevvrndac"
        PDS_CRAWLERS="https://bsky.network"
        LOG_ENABLED="false"
      }
    }
  }
}

