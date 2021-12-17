module "rsk_testnet" {
    source = "../../app/rsknode"
    project = "enormous"
    workspace = "rsk-testnet"
    https = 1

    hosted_zones = {
        "default" = {
            name = "default"
            host = "rsk-testnet.enormous.cloud"
            local_port = 4080
        }
        "traefik" = {
            name = "traefik"
            host = "traefik.rsk-testnet.enormous.cloud"
            local_port = 4081
        }
    }
    trusted_ips = ["77.87.40.136"]
    volume_exchange = "${path.cwd}/exchange"
}
