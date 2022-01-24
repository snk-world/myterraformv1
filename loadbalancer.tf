data "yandex_lb_target_group" "events_api_tg" {
  name = yandex_compute_instance_group.events_api_ig.load_balancer[0].target_group_name
}

resource "yandex_lb_network_load_balancer" "events_api_lb" {
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
    target_group_id = data.yandex_lb_target_group.events_api_tg.id

    healthcheck {
      name = "http"
      http_options {
        port = 8080
        path = "/status"
      }
    }
  }
}

