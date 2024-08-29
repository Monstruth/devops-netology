
resource "yandex_lb_network_load_balancer" "n15-net-lb" {
  name = "n15-net-lb"

  listener {
    name = "n15-net-lb"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.n15-net-lb.load_balancer[0].target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

