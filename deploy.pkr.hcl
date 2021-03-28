source "docker" "application" {
  image = "httpd:2.4"
  commit = true
    changes = [
      "EXPOSE 80"
    ]
  post-processors "docker-tag" {
    repository = "heiran/simple-packer-project"
    tag = "1.0"
  }
}

build {
  sources = ["source.docker.application"]

  provisioner "ansible" {
    playbook_file = "inventory/deploy.yml"
    host_alias = "web"
    groups = ["apacheservers"]
  }

}


