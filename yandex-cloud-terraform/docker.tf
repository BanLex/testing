resource "yandex_compute_instance" "docker" {
  count = local.countss
  name = "docker-${count.index}"
  
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
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
  
  provisioner "local-exec" {
    command = "echo 'HostName ${slef.nat_ip_address} \\nUser banlex' >> ../ops/ssh-config && echo '${self.ip_address}\t${self.name}>>hosts'"
  }
}
