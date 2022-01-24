#============== provider setup ===============

terraform {

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
  token     =  var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
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

#============== output ===============


output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
