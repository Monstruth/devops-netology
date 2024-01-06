###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "compute image"
}

#variable "vm_web_instance" {
 # type        = string
  #default     = "netology-develop-platform-web"
 # description = "compute instance"
# }

variable "platform" {
  type        = string
  default     = "platform"
}

variable "vm_web_resources" {
  type = map
  default = {
    cores          = 2
    memory         = 1
    core_fraction  = 5
  }
}

###ssh vars

#variable "vms_ssh_root_key" {
 # type        = string
  # default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDY7TuKDvoZAcFEUMzHSAFhLXcGlr5nvG45h/emkpJx2 monztro@monztro-laptop"
 # description = "ssh-keygen -t ed25519"
# }

variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-key            = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDY7TuKDvoZAcFEUMzHSAFhLXcGlr5nvG45h/emkpJx2"
  }
}