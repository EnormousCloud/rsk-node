resource "docker_container" "eth" {
  image = docker_image.eth.latest
  name  = local.hostname
  restart = "always"

  log_opts = {
    "max-file" = "3"
    "max-size" = "100m"
  }

  dynamic ports {
      for_each = local.ports
      content {
          internal = ports.value.internal
          external = ports.value.external
          protocol = ports.value.protocol
      }
  }
  
  networks_advanced {
    name  = local.network_id
  }
  
  labels {
    label = "project"
    value = local.project
  }

  labels {
    label = "host"
    value = local.hostname
  }

  labels {
    label = "role"
    value = "rsk"
  }
  
  volumes {
    volume_name = docker_volume.storage.name
    read_only = false
    container_path = "/var/lib/rsk"
  }

  volumes {
    volume_name = docker_volume.logs.name
    read_only = false
    container_path = "/var/log/rsk"
  }

  upload {
    file = "/etc/rsk/node.conf"
    content = <<EOF
blockchain.config.name = "testnet"
database.dir = /var/lib/rsk/database/testnet

rpc {
    providers : {
        web: {
            cors: "localhost",
            http: {
                enabled: true,
                bind_address: "0.0.0.0",
                hosts: ["${local.hostname}"],
                port: 4444,
            },
            ws: {
                enabled: false,
                bind_address: "0.0.0.0",
                port: 4445,
            }
        }
    }

    modules = [
        {
            name: "eth",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "net",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "rpc",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "web3",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "evm",
            version: "1.0",
            enabled: "false"
        },
        {
            name: "sco",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "txpool",
            version: "1.0",
            enabled: "true",
        },
        {
            name: "debug",
            version: "1.0",
            enabled: "false",
        },        
        {
            name: "personal",
            version: "1.0",
            enabled: "false"
        }
    ]
}
    EOF

  }
}

