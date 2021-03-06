## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | >= 2.13.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.69.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vm1"></a> [vm1](#module\_vm1) | ./vmmodule | n/a |
| <a name="module_vm2"></a> [vm2](#module\_vm2) | ./vmmodule | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.network-1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.69.0/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet-1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.69.0/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.subnet-2](https://registry.terraform.io/providers/yandex-cloud/yandex/0.69.0/docs/resources/vpc_subnet) | resource |
| [yandex_compute_image.my_image1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.69.0/docs/data-sources/compute_image) | data source |
| [yandex_compute_image.my_image2](https://registry.terraform.io/providers/yandex-cloud/yandex/0.69.0/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_pass"></a> [admin\_pass](#input\_admin\_pass) | n/a | `string` | `""` | no |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | n/a | `string` | n/a | yes |
| <a name="input_cores"></a> [cores](#input\_cores) | n/a | `number` | `2` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | n/a | `number` | `50` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | n/a | `string` | `"network-nvme"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | n/a | `string` | n/a | yes |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | n/a | `string` | `"windows-2019-dc-gvlk"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `4` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_nat"></a> [nat](#input\_nat) | n/a | `bool` | `true` | no |
| <a name="input_network"></a> [network](#input\_network) | n/a | `string` | `"ya-network"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `string` | `"ya-network"` | no |
| <a name="input_subnet_v4_cidr_blocks"></a> [subnet\_v4\_cidr\_blocks](#input\_subnet\_v4\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "192.168.10.0/16"<br>]</pre> | no |
| <a name="input_timeout_create"></a> [timeout\_create](#input\_timeout\_create) | n/a | `string` | `"10m"` | no |
| <a name="input_timeout_delete"></a> [timeout\_delete](#input\_timeout\_delete) | n/a | `string` | `"10m"` | no |
| <a name="input_token"></a> [token](#input\_token) | n/a | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | n/a | `string` | `""` | no |
| <a name="input_user_pass"></a> [user\_pass](#input\_user\_pass) | n/a | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | n/a |
| <a name="output_external_ip_address_vm_2"></a> [external\_ip\_address\_vm\_2](#output\_external\_ip\_address\_vm\_2) | n/a |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | n/a |
| <a name="output_internal_ip_address_vm_2"></a> [internal\_ip\_address\_vm\_2](#output\_internal\_ip\_address\_vm\_2) | n/a |
