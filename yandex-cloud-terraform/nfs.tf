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
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
  
  provisioner "local-exec" {
    command = "echo 'HostName ${yandex_compute_instance.nfs.network_interface.0.nat_ip_address} \\nUser banlex' >> ../ops/ssh-config && echo '${yandex_compute_instance.nfs.network_interface.0.ip_address}\t${yandex_compute_instance.nfs.name}>>hosts'"
  }
}
