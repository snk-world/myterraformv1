terraform {

#============== provider setup ===============

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-bucket-mentor-nnnew"
    region     = "ru-central1-a"
    key        = "terrstate1/mystate1.tfstate"
    access_key = "WfrA4riGoi9Q_MR3AR7t"
    secret_key = "xq9aqGnniYSeo_1J4Dju5o0ZJMquupH01ejYvrcb"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

  required_version = ">= 1.0"
}

provider "yandex" {
  token     = "AQAAAAAP98iZAATuwerf78wHaUKOqX4JJSSohL4"
  cloud_id  = "b1gqjs8i0bu7flvn477a"
  folder_id = "b1gnsqbt87s9heit3avt"
  zone      = "ru-central1-a"
}

#============== vm images ===============
data "yandex_compute_image" "my_image1" {
  family = "lemp"
}

data "yandex_compute_image" "my_image2" {
  family = "lamp"
}

#============== vm create  ===============
module "vm1" {
  source     = "./vmmodule"
  nname      = "vmm1"
  image_idd  = data.yandex_compute_image.my_image1.id
  subnet_idd = yandex_vpc_subnet.subnet-1.id
}

module "vm2" {
  source     = "./vmmodule"
  nname      = "vmm2"
  image_idd  = data.yandex_compute_image.my_image2.id
  subnet_idd = yandex_vpc_subnet.subnet-2.id
}

#============== vm network ===============
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

#============== load balancer ===============
resource "yandex_alb_load_balancer" "test-balancer" {
  name        = "my-load-balancer"

  network_id  = yandex_vpc_network.network-1.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id 
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 8080 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }    
}

resource "yandex_alb_http_router" "tf-router" {
  name      = "my-http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}
#============== OUTPUT ===============

output "internal_ip_address_vm_1" {
  value = module.vm1.internal_ip_address_vm_1
}

output "external_ip_address_vm_1" {
  value = module.vm1.external_ip_address_vm_1
}

output "internal_ip_address_vm_2" {
  value = module.vm1.internal_ip_address_vm_1
}

output "external_ip_address_vm_2" {
  value = module.vm1.external_ip_address_vm_1
}
