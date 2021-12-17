resource "docker_volume" storage {
  name = "${local.project}-rsk-storage-${local.postfix}"
}
