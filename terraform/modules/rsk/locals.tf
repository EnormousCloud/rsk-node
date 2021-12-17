locals {
    network_id = var.network_params.network_id
    project = var.network_params.project
    postfix = var.network_params.postfix

    hostname = "eth-${var.network_params.postfix}"
    ports = [
        # {
        #     protocol = "tcp" 
        #     internal = 4444
        #     external = 4444
        # },
        {
            protocol = "udp" 
            internal = 50505
            external = 50505
        },
        {
            protocol = "tcp" 
            internal = 50505
            external = 50505
        }
    ]
}