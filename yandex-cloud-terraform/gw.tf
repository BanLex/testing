resource "yandex_compute_instance" "gw" {
  name = "gw"
  fqdn = "gw"
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
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }

  provisioner "local-exec" {
    command = "echo 'HostName ${yandex_compute_instance.gw.network_interface.0.nat_ip_address} \\nUser banlex' >> ../ops/ssh-config"
  }
}
