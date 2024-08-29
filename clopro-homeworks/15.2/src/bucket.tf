
// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.service_account_id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "netology_15_2" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "netology-monstro-bucket"

  anonymous_access_flags {
    read = true
    list = true
  }
}

resource "yandex_storage_object" "monstro" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.netology_15_2.bucket
  key        = "367044.jpg"
  source     = "367044.jpg"
  acl        = "public-read"
  depends_on = [yandex_storage_bucket.netology_15_2]
}