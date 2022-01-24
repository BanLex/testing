
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}



provider "yandex" {
  token     = "${ var.oauth }"
  cloud_id  = "${ var.cloud }"
  folder_id = "${ var.folder }"
  zone      = "ru-central1-a"
}
