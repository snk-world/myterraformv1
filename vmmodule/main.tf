terraform {
  required_providers {
	yandex = {
      source = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
}
variable "nname" {
      default     = "default_mane"
	  description = "A name of VM insance"
}
variable "image_idd" {
      default     = "Centos-8"
	  description = "Image of the VM instance"
}

variable "subnet_idd" {
	description = "Subnet area"
}



resource "yandex_compute_instance" "vm-1" {
  name = var.nname

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_idd
    }
  }

  network_interface {
    subnet_id = var.subnet_idd
    nat       = true
  }

  metadata = {
    ssh-keys = "aadmin2:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjXpSuDI4fp3lU5rLum6oALD2L7MNkSyJ5HJbETIkvvgxanLPSGBKWVC+/G1E4A5ZDeBZfgonOD9jyIMSsMz6TOGKbnkZEA6hQVt/Uz1ofrXquVjwOyV4R+jWWQdjgIyryrK6Eus8UmkLUwWnPqtdFovzzcENWrJfkFAku3TozTfBELJjZyyKOfDe4M6SKIEWdy0aqVB/GKsuwjCm2WOo7gYkfR970wTzalNNSRvZ8sEjkMka4zeYH7tBoAoRVvL2XzagnJDQac/sBO8eHMgwKpByBd8U7vVBrEWlW/wN/af4G1ThrGQA7561lauJAndLTv6GfGSdHc2zcsD3EpgQqXF4Z7i9eln9VcvXu7n1GtX55k3aZaJhrHiKF53t7EVNGwbLjll+xmXTZpDT2Tt1aaDw1LuPIVAaNuqathFxQ4fwuA3XRgywM6bdgXdHzcqTSvFemyTmEw/vh2Jb5alAMA18H+5+al40T/C2CgP9m3jEMFJV5F1JTN1JC16Fiw80= aadmin2"
  }
  
  load_balancer {
    target_group_name = "events-api-tg"
  }

}


output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
