#============== vm images ===============
data "yandex_compute_image" "my_image11" {
  family = "lemp"
}

data "yandex_compute_image" "my_image22" {
  family = "lamp"
}


#============== vms ===============

resource "yandex_compute_instance" "vm-1" {
  name = "lemp11"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image11.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "aadmin2:${file("~/.ssh/id_rsa.pub")}"
  }
  
}

resource "yandex_compute_instance" "vm-2" {
  name = "lemp22"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image22.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = true
  }

  metadata = {
    ssh-keys = "admin2:${file("~/.ssh/id_rsa.pub")}"
  }
  
}

#============== vms ===============

