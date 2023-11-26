
resource "yandex_compute_instance" "for_each" {
  for_each = {
    for index, vm in var.each_vm : vm.vm_name => vm
    }
  name        = "${each.value.vm_name}"
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

  metadata = local.ssh_keys_and_serial_port

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk=number }))
  default = [
    { vm_name="main",  cpu=4, ram=2, disk=10 },
    { vm_name="replica", cpu=2, ram=1, disk=15 }
  ]
}
