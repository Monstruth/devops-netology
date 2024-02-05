# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

![01](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/8af62966-3748-4d9f-a438-296138b9682a)

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

![2024-02-04_00-51-01](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/7eec993c-6a2b-4aa1-809c-583bd31ac0de)

![02](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/3e7a41e8-16a1-4f67-8943-38005ca80521)


2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

![2024-02-04_03-42-55](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/52aa9432-87e5-4112-b38b-3d3c82405e10)

![03](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/3335ed94-8a44-45ff-9428-fc369050deb6)

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

![2024-02-05_15-29-58](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/c2560235-87ae-4afb-928e-d333f388638c)

![04](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/b393353d-0c10-464e-b2f1-86ff9e92a312)

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

![2024-02-05_15-49-03](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/47c53972-82c7-4390-b9af-500188dbda65)

![05](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/98496c39-fcc7-47de-9f22-7476dd04f8d6)

![06](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/ad2d2ee3-591d-406f-97ac-f3e0706a5061)

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).

![2024-02-05_16-02-35](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/c2a29020-ca94-4ef9-a68d-e55fbac152a7)

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.

![2024-02-05_16-42-34](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/b6472106-0e4e-4cdf-8652-be1853629f42)

![07](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/68f91e62-0810-4552-84e6-0037dc92159c)

7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

[Репозиторий с ролью](https://github.com/perepelitsyn-alexei/clickhouse.git)


9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
