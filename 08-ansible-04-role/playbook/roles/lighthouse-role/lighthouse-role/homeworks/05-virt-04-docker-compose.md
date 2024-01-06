
## Задача 1

Создать собственный образ  любой операционной системы (например, ubuntu-20.04) с помощью Packer ([инструкция](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart))

Для получения зачета вам необходимо предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.

![packer](https://user-images.githubusercontent.com/105611781/216757868-4bf34454-bac6-4de4-9090-e3a69b8d7404.png)

![packer1](https://user-images.githubusercontent.com/105611781/216757881-0539c402-879c-40a7-a483-cb9a5aa13590.png)


## Задача 2

Создать вашу первую виртуальную машину в YandexCloud с помощью terraform. 
Используйте terraform код в директории ([src/terraform](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/terraform))

```
root@monztro-laptop:/home/monztro/yandex-cloud# terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8q7aeirfjvj1rnucb3"
              + name        = "root-node01"
              + size        = 30
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = "e9boihmakj59657efpkh"
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Creation complete after 45s [id=fhm7p2lj9g1sovd011vr]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
root@monztro-laptop:/home/monztro/yandex-cloud# 
```

![2](https://user-images.githubusercontent.com/105611781/217668177-ca3c1c59-4720-4b78-b3f4-dfdc1f6d3f17.png)

Для получения зачета, вам необходимо предоставить вывод команды terraform apply и страницы свойств созданной ВМ из личного кабинета YandexCloud.

## Задача 3

С помощью ansible и docker-compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana .
Используйте ansible код в директории ([src/ansible](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/ansible))


Для получения зачета вам необходимо предоставить вывод команды "docker ps" , все контейнеры, описанные в ([docker-compose](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/docker-compose.yaml)),  должны быть в статусе "Up".

```
[centos@node01 ~]$ docker ps
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied
[centos@node01 ~]$ sudo docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED              STATUS                    PORTS                                                                              NAMES
ab21d6dcaf26   grafana/grafana:7.4.2              "/run.sh"                About a minute ago   Up 48 seconds             3000/tcp                                                                           grafana
7e722e73ef60   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   About a minute ago   Up 47 seconds (healthy)   8080/tcp                                                                           cadvisor
65b4dedd38fe   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   About a minute ago   Up 46 seconds             9090/tcp                                                                           prometheus
ab92e716917d   stefanprodan/caddy                 "/sbin/tini -- caddy…"   About a minute ago   Up 45 seconds             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy
f4f89d49ff2f   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   About a minute ago   Up 46 seconds             9093/tcp                                                                           alertmanager
ef6e030d418a   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   About a minute ago   Up 45 seconds             9100/tcp                                                                           nodeexporter
aa422665c692   prom/pushgateway:v1.2.0            "/bin/pushgateway"       About a minute ago   Up 45 seconds             9091/tcp                                                                           pushgateway
[centos@node01 ~]$ 
```
![docker1](https://user-images.githubusercontent.com/105611781/217666876-e9b2dd91-dc0d-4efe-b458-7cf7e271bdac.png)


## Задача 4

1. Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
2. Используйте для авторизации логин и пароль из ([.env-file](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/.env)).
3. Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose панели с графиками([dashboards](https://grafana.com/docs/grafana/latest/dashboards/use-dashboards/)).
4. Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.

![prom](https://user-images.githubusercontent.com/105611781/217668397-be8d4632-d962-4997-976f-686d23d8733e.png)

![dock](https://user-images.githubusercontent.com/105611781/217668428-13c9a682-8e2b-4a4b-bcf0-0096955a64a6.png)


