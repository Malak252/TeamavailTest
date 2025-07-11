terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.24.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "teamavail_net" {
  name = "teamavail_network"
}

resource "docker_image" "coolestv" {
  name = "coolestv"
  build {
    path    = "../"
    dockerfile = "../Dockerfile"
  }
}

resource "docker_container" "app" {
  name  = "teamavail_app"
  image = docker_image.coolestv.name
  networks_advanced {
    name = docker_network.teamavail_net.name
  }

  ports {
    internal = 3000
    external = 4040
  }

  env = [
    "NODE_ENV=development",
    "PORT=3000"
  ]
}

