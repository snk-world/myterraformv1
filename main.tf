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



#============== vm network ===============


resource "yandex_vpc_network" "internal" {
  name = "internal"
}

resource "yandex_vpc_subnet" "internal-a" {
  name           = "internal-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["172.16.1.0/24"]
}

resource "yandex_vpc_subnet" "internal-b" {
  name           = "internal-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["172.16.2.0/24"]
}

resource "yandex_vpc_subnet" "internal-c" {
  name           = "internal-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.internal.id
  v4_cidr_blocks = ["172.16.3.0/24"]
}

#============== 111 ===============

resource "yandex_iam_service_account" "docker" {
  name        = "docker"
  description = "service account to use container registry"
}

resource "yandex_iam_service_account" "instances" {
  name        = "instances"
  description = "service account to manage VMs"
}
