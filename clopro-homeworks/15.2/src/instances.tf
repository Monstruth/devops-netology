
resource "yandex_compute_instance_group" "n15-net-lb" {
  name                = "n15-net-lb"
  service_account_id = var.service_account_id
  deletion_protection = false
  depends_on          = [yandex_storage_bucket.netology_15_2, yandex_storage_object.monstro]

  load_balancer {
    target_group_name = "n15-net-lb"
  }

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        type     = "network-hdd"
        size     = "20"
      }
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = yandex_vpc_network.network.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = false
      ipv6       = false
    }

    network_settings {
      type = "STANDARD"
    }

    metadata = {
      user-data = <<EOF
#!/bin/bash
echo "<html><p>Netwrok Load Balancer</p><p>"`cat /etc/hostname`"</p><img src="https://storage.yandexcloud.net/${yandex_storage_object.monstro.bucket}/${yandex_storage_object.monstro.key}"></html>" > /var/www/html/index.html
EOF
      ssh-keys  = var.vm_metadata.ssh-key
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 3
    max_expansion   = 0
    max_deleting    = 3
    max_creating    = 3
  }
  health_check {
    interval = 30
    timeout  = 10
    tcp_options {
      port = 80
    }
  }
}
