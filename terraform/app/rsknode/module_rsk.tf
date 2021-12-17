module "rsk" {
  source = "../../modules/rsk"

  network_params = module.network.params
}

