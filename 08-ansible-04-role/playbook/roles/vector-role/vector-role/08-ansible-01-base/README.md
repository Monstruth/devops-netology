# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

![01](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/5b3f800e-6bd7-4abe-8868-59ac00417a1e)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

![02](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/b8c80bde-926c-4162-8bcf-df9fcb867485)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

![03](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/f65793bb-46d2-405f-a2d6-992250a5b7ee)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![04](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/b25713a1-b024-4016-911f-709645023a05)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![06](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/38c1fc10-03b1-4ae9-b326-963ac4158af7)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

![07](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/d3ac8215-c4a1-4e45-a1f5-7b99b7cb8c9d)

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![08](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/2f12e472-a17d-4bb9-aa79-a527e4a3f749)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

![09](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/4ebda527-e7f8-435e-a9af-2b37586d57e3)

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![11](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/69a2174a-5d04-441b-ad9b-fd3eb9d46609)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

