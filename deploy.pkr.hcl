source "docker" "application" {
  image = "httpd:2.4"
  commit = true
    changes = [
      "EXPOSE 80"
    ]
}

build {
  sources = ["source.docker.application"]

  provisioner "ansible" {
    playbook_file = "inventory/deploy.yml"
    host_alias = "web"
    groups = ["apacheservers"]
  }
  post-processors {
    post-processor "docker-tag" {
      repository = "heiran/packer-application"
      tags = var.image_tag
    }
  }
  post-processor "docker-push" {
    login = true
    login_username = var.docker_user
    login_password = var.docker_password
  }

}
# PKR_VAR_docker_user
variable "docker_user" {
  type = string
}

variable "docker_password" {
  type = string
}

variable "image_tag" {
  type = list(string)
}