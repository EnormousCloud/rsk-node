resource "docker_volume" logs {
  name = "${local.project}-rsk-logs-${local.postfix}"
}
