resource "yandex_compute_instance" "nfs" {
  name = "nfs"
  
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
    nat       = false
    ip_address = "192.168.10.4"
  }

  metadata = {
    user-data = "${file("user")}"
  }
  
}
