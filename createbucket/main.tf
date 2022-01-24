terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token ="AQAAAAAP98iZAATuwerf78wHaUKOqX4JJSSohL4"
  cloud_id                 = "b1gqjs8i0bu7flvn477a"
  folder_id                = "b1gnsqbt87s9heit3avt"
  zone                     = "ru-central1-a"
}


# Создаем хранилище
resource "yandex_storage_bucket" "mybucket" {
  bucket     = "tf-state-bucket-mentor-nnnew"
  access_key = "WfrA4riGoi9Q_MR3AR7t"
  secret_key = "xq9aqGnniYSeo_1J4Dju5o0ZJMquupH01ejYvrcb"
}

output "bucketname" {
  value = yandex_storage_bucket.mybucket.bucket
}