resource "yandex_dns_zone" "vpc-peering-zone" {
  name             = "vpc-peering-zone"
  zone             = "mdb.yandexcloud.net."
  public           = false
  private_networks = [yandex_vpc_subnet.subnet-1.id]
}
