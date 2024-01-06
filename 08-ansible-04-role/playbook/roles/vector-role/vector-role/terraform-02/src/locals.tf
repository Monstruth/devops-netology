
locals {
  vm_db_name = "netology-${var.vpc_name}-${var.platform}-db"
}

locals {
  vm_web_name = "netology-${var.vpc_name}-${var.platform}-web"
}
