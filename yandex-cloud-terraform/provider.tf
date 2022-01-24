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

data "yandex_storage_object" "s3" {
  backend = "s3"
  config {    
    endpoint   = "storage.yandexcloud.net"
    bucket     = "banlex.terraform"
    region     = "us-east-1"
    key        = "tester.tfstate"
    access_key = "${local.access_key}"
    secret_key = "${local.secret_key}"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = "${ local.oauth }"
  cloud_id  = "${ local.cloud }"
  folder_id = "${ local.folder }"
  zone      = "ru-central1-a"
}
