

 #variable "vm_db_instance" {
 # type        = string
 # default     = "netology-develop-platform-db"
 # description = "compute instance"
#}

variable "vm_db_resources" {
  type = map
  default = {
    cores          = 2
    memory         = 2
    core_fraction  = 20
  }
}
