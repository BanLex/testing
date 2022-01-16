terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "${{ YC_OAUTH }}"
  cloud_id  = "${{ YC_CLOUD }}"
  folder_id = "${{ YC_FOLDER }}"
  zone      = "ru-central1-a"
}
