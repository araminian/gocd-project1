source "docker" "application" {
  image = "ubuntu"
  commit = true
}

build {
  sources = ["source.docker.application"]
}