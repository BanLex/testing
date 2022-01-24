resource "yandex_compute_instance" "gw" {
  name = "gw"
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8drj7lsj7btotd7et5"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
    ip_address = "192.168.10.3"
    nat_ip_address = "84.201.129.141"
  }

  metadata = {
    user-data = "${file("user")}"
  }

}
