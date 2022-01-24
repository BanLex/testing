locals {
  countss = 4
}

terraform {
  backend "s3" {}
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}


provider "yandex" {
  token     = "${ local.oauth }"
  cloud_id  = "${ local.cloud }"
  folder_id = "${ local.folder }"
  zone      = "ru-central1-a"
}
