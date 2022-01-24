resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_dns_zone" "zone1" {
  name        = "my-private-zone"
  description = "desc"

  labels = {
    label1 = "label-1-value"
  }

  zone             = "example.com."
  public           = false
  private_networks = [yandex_vpc_network.network-1.id]
}

resource "yandex_dns_recordset" "gw" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "gw"
  type    = "A"
  ttl     = 200
  data    = ["192.168.10.3"]
}

resource "yandex_dns_recordset" "nfs" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "nfs"
  type    = "A"
  ttl     = 200
  data    = ["192.168.10.4"]
}
resource "yandex_dns_recordset" "docker" {
  count = 4
  zone_id = yandex_dns_zone.zone1.id
  name    = "docker-${count.index}"
  type    = "A"
  ttl     = 200
  data    = ["192.168.10.1${count.index}"]
}
