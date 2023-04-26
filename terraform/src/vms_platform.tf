
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "compute image"
}

variable "vm_db_instance" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "compute instance"
}
