
resource "yandex_lb_target_group" "my-target-group" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    address   = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }
}


resource "yandex_lb_network_load_balancer" "foo" {
  name = "events-api-lb"

  listener {
    name = "events-api-listener"
    port = 80
    target_port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.my-target-group.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 8080
        path = "/status"
      }
    }
  }
  depends_on = [yandex_lb_target_group.my-target-group]
}

