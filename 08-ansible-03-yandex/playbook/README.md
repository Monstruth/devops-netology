## Playbook устанавливает и настраивает конфигурацию связки Clickhouse, Vector и Lighthouse на трёх хостах, в данном случае использовалось Яндекс Облако

Сам playbook описан в файле ```site.yml``` содержит 4 задачи:
#### 1. Первая задача объединяет последовательность тасок по инсталяции Clickhouse. 
 используются параметры:
- ```clickhouse_version: "22.3.3.44"``` - версия Clickhouse
- ```clickhouse_packages: ["clickhouse-client", "clickhouse-server", "clickhouse-common-static"]``` - список пакетов для установки

Task'и:
- ```TASK [Clickhouse. Get clickhouse distrib]``` - скачивает rpm-пакеты с дистрибутивами с помощью модуля ```ansible.builtin.get_url``` при этом использованы параметры ```block``` и ```rescue``` то есть использован блок восстановления задачи в случае сбоя, в данном случае при ошибке скачивания дистрибубутива, будет использован другой вариант закачки.
- ```TASK [Install clickhouse packages]``` - устанавливает набор пакетов с помощью модуля ```ansible.builtin.yum```
- ```notify [Start clickhouse service]``` - инициирует внеочередной запуск хандлера ```Start clickhouse service```
- ```RUNNING HANDLER [Start clickhouse service]``` - для старта сервера ```clickhouse``` в хандлере используется модуль ```ansible.builtin.service```
- ```TASK [Pause 20 sec]``` - устанавливает паузу в 20 секунд с помощью модуля ```ansible.builtin.pause```, чтобы сервер Clickhouse успел запуститься. Иначе следующая задача по созданию БД может завершиться ошибкой, т.к. сервер еще не успел подняться
- ```TASK [Create database]``` - создает инстанс базы данных Clickhouse

#### 2. Вторая задача объединяет последовательность тасок по инсталяции Vector. 
 используются параметры:
- ```vector_version: "0.33.0"``` - версия Vector
- ```vector_architecture: "x86_64"``` - архитектура ОС

Task'и:
- ```TASK [Get Vector distrib]``` - скачивает архив с дистрибутивом с помощью модуля ```ansible.builtin.get_url```
- ```TASK [Unarchive Vector package]``` - распаковывает скачанный архив с помощью модуля ```ansible.builtin.unarchive```
- ```TASK [Create Vector directory]``` - создает каталог для данных Vector с помощью модуля ```ansible.builtin.file```
- ```RUNNING HANDLER [Start Vector service]``` - инициируется запуск хандлера ```Start Vector service```
- ```TASK [Pause 20 sec]``` - устанавливает паузу в 20 секунд с помощью модуля ```ansible.builtin.pause```
- ```TASK [Template file]``` - копирует файл конфигурации Vector

#### 3. Третья задача устанавливает lighthouse
- ```TASK [Install GIT]``` - в претаске сначала устанавливается GIT на хост
- ```TASK [Get lighthouse distrib]``` - устанавливается сам lighthouse

#### 4. Чётвёртая задача устанавливает сервер NGINX на хост с lighthouse и производит конфигурацию
- ```TASK [nstall the 'Development tools' package group]``` - в претаске устанавливается пакет ```Development tools```
- ```TASK [Get NGINX version]``` - преверяется установлен ли в системе NGINX, если его нет запускается блок
по его установке ```Get and Install NGINX```
- ```TASK [Configure nginx config for site]``` - производится конфигурация NGINX для lighthouse путём копирования файла шаблона ``nginx.cfg.j2``
- ```TASK [Make config for lighthouse]``` - производится конфигурация lighthouse копированием файла шаблона ``default.cfg.j2``

----
