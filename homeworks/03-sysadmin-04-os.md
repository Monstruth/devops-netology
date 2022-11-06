1

![101](https://user-images.githubusercontent.com/105611781/199496935-1339bb42-ea7b-46c9-9cee-4fd70d8637e1.PNG)

![102](https://user-images.githubusercontent.com/105611781/199496971-b2baa443-93a1-421a-a169-811c04193c32.PNG)

![103](https://user-images.githubusercontent.com/105611781/199497009-b1108884-4f6a-42bb-9eaf-7a8f460f690e.PNG)

на примере юнита cron
![106](https://user-images.githubusercontent.com/105611781/200078614-3edf1090-5502-495e-bc3d-09330d775687.PNG)
видим как
в файле /etc/default/cron прописываются сами значения переменных. Далее в unit-файле в разделе [Service] через EnvironmentFile указывается, откуда значения параметров забирать и после ExecStart указывается сам параметр через $:

EnvironmentFile=-/etc/default/cron

ExecStart=/usr/sbin/cron -f $EXTRA_OPTS

2

![104](https://user-images.githubusercontent.com/105611781/199497039-226e1d93-705a-43c1-b024-c0d9c24d6212.PNG)

![105](https://user-images.githubusercontent.com/105611781/199497085-c258b97e-de4a-4afd-9837-d1b28586a7ce.PNG)

node_load 1 - средняя загрузка за минуту (Load averages)

node_filesystem_avail_bytes – использование файловой системы

node_network_receive_bytes_total — сетевой трафик

node_cpu_seconds_total - загрузка процессора

node_memory_MemTotal_bytes - загрузка памяти

3

![02](https://user-images.githubusercontent.com/105611781/199497428-9112eec1-a3f9-4567-8af2-9154a17d04f0.PNG)

4

![004](https://user-images.githubusercontent.com/105611781/200083686-7921644f-18bc-4c51-be5c-d321d89ac850.PNG)

5

![05](https://user-images.githubusercontent.com/105611781/200169745-0aee46ac-adbb-48c6-a40d-5151f0f278a9.PNG)

nr_open - обозначает максимальное количество дескрипторов файлов, которые может выделить процесс. Значение по умолчанию равно 1024 * 1024 (1048576), чего должно быть достаточно для большинства машин.
согласно ulimit --help видим что аргумент -n это и есть максимальное количество дескрипторов открытых файлов. по умолчанию для пользователя ограничение -n устанавливается как мягкое ограничение через пареметр -S. жесткое ограниечение -Hn равно уведенному параметру nr_open

6

запускаем процесс sleep 1h в отдельном неймспейсе

![06](https://user-images.githubusercontent.com/105611781/200172419-8e9b7034-badc-4a39-a620-1ced2459af25.PNG)

через второй терминал находим пид процесса слип и через nsenter смотрим пид ппроцесса в запущенном неймспейсе

![061](https://user-images.githubusercontent.com/105611781/200172528-37f44145-1730-45d4-ae1e-843a69825391.PNG)

7

это форк бомба

: – это имя функции

:|: вызывает саму функцию и порождает другой процесс

& переводит процесс в фоновый режим, чтобы его нельзя было легко убить
; отмечает конец функции

: снова вызывает функцию

![07](https://user-images.githubusercontent.com/105611781/200174386-e6e25ac8-1ebb-4338-8c3c-4fd2c8aadb17.PNG)

![071](https://user-images.githubusercontent.com/105611781/200174398-6a936ea6-0abf-43a1-b13d-68595dff03c8.PNG)

