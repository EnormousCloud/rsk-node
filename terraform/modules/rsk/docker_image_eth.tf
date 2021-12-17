resource "docker_image" "eth" {
  name = "rsknode"
  build {
    path = "${path.module}/RSK-Node"
    dockerfile = "Dockerfile.TestNet"
  }
}