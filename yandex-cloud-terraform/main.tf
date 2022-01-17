terraform {
  backend "s3" {}
 
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
data "terraform_remote_state" "state" {
  backend = "s3"
  config {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "banlex.terraform"
    region     = "ru-central1"
    key        = "tester.tfstate"
    access_key = local.access_key
    secret_key = local.secret_key

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}



provider "yandex" {
  token     = "${ local.oauth }"
  cloud_id  = "${ var.cloud }"
  folder_id = "${ var.folder }"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8f30hur3255mjfi3hq"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

