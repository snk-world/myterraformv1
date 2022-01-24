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
    ssh-keys = "admin2:${file("~/.ssh/id_rsa.pub")}"
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
