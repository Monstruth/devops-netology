# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

![05](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/b9880e09-58b4-4086-a70e-cdb2d37d3fd5)

Не было имени у таски. у block стоял минусик, а он там не нужен. Не были установлены права на создание папок и файлов.

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

![06](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/4872fb3b-ae32-402e-a52b-86f8629418ea)

при проверки чек действий никаких не производится, происходит проверка по сути синтаксиса. поэтому он и ругается, так как установочные файлы не скачиваются и тд.

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

![07](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/6ef6c719-22dc-49fb-a85f-63c4ec1f1ee0)

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

![08](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/c6c9b7eb-b31d-4372-ac1e-f9bd18141114)

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

[site.yml](src%2Fplaybook%2Fsite.yml) содержит 2 блока:
#### 1. Первый блок объединяет последовательность задач по инсталяции Clickhouse. 
В блоке используются параметры:
- ```clickhouse_version: "22.3.3.44"``` - версия Clickhouse
- ```clickhouse_packages: ["clickhouse-client", "clickhouse-server", "clickhouse-common-static"]``` - список пакетов для установки

Task'и:
- ```TASK [Clickhouse. Get clickhouse distrib]``` - скачивает rpm-пакеты с дистрибутивами с помощью модуля ```ansible.builtin.get_url``` при этом использованы параметры ```block``` и ```rescue``` то есть использован блок восстановления задачи в случае сбоя, в данном случае при ошибке скачивания дистрибубутива, будет использован другой вариант закачки.
- ```TASK [Install clickhouse packages]``` - устанавливает набор пакетов с помощью модуля ```ansible.builtin.yum```
- ```notify [Start clickhouse service]``` - инициирует внеочередной запуск хандлера ```Start clickhouse service```
- ```RUNNING HANDLER [Start clickhouse service]``` - для старта сервера ```clickhouse``` в хандлере используется модуль ```ansible.builtin.service```
- ```TASK [Pause 20 sec]``` - устанавливает паузу в 20 секунд с помощью модуля ```ansible.builtin.pause```, чтобы сервер Clickhouse успел запуститься. Иначе следующая задача по созданию БД может завершиться ошибкой, т.к. сервер еще не успел подняться
- ```TASK [Create database]``` - создает инстанс базы данных Clickhouse

#### 2. Второй блок объединяет последовательность задач по инсталяции Vector. 
В блоке используются параметры:
- ```vector_version: "0.33.0"``` - версия Vector
- ```vector_architecture: "x86_64"``` - архитектура ОС

Task'и:

- ```TASK [Get Vector distrib]``` - скачивает архив с дистрибутивом с помощью модуля ```ansible.builtin.get_url```
- ```TASK [Unarchive Vector package]``` - распаковывает скачанный архив с помощью модуля ```ansible.builtin.unarchive```
- ```TASK [Create Vector directory]``` - создает каталог для данных Vector с помощью модуля ```ansible.builtin.file```
- ```RUNNING HANDLER [Start Vector service]``` - инициируется запуск хандлера ```Start Vector service```
- ```TASK [Pause 20 sec]``` - устанавливает паузу в 20 секунд с помощью модуля ```ansible.builtin.pause```
- ```TASK [Template file]``` - копирует файл конфигурации Vector

---
