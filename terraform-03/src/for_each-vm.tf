
resource "yandex_compute_instance" "for_each" {
  for_each = {
    main = var.each_vm[0]
    replica = var.each_vm[1]
  }
  name        = "${each.key}"
  platform_id = "standard-v1"
  resources {
    cores         = "${each.value.cpu}"
    memory        = "${each.value.ram}"
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = "${each.value.disk}"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }



}

variable "each_vm" {
  type = list(object({  cpu=number, ram=number, disk=number }))
  default = [
    {  cpu=4, ram=2, disk=10 },
    {  cpu=2, ram=1, disk=15 }
  ]
}