# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД,
![01](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/01362ed8-fefe-47b4-8e33-cae7c5fe610c)

- подключения к БД,

![02](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/efd5685b-86a6-4bbf-ad1f-e0b317916b02)

- вывода списка таблиц,

![03](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/d1135e6f-4c12-47f5-bb33-78a6f6f22dbb)

- вывода описания содержимого таблиц,

![04](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/6ad29e27-432b-4646-8ad0-11449d87d00a)

- выхода из psql.

![05](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/e04254c8-045c-4db8-8629-5990af880ce2)

## Задача 2

Используя `psql`, создайте БД `test_database`.

![06](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/d5d5c9a3-2090-44f6-b86c-c9ebe770d994)

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

![07](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/67bc4d75-a5a5-41cc-8351-1b5b7b76d3fb)

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

![08](https://github.com/perepelitsyn-alexei/devops-netology/assets/105611781/5195851c-661d-4463-acc3-adc8c92a8a28)


## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

```postgresql
test_database=# CREATE TABLE "orders_1 - price>499" (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO "orders_1 - price>499" SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE "orders_2 - price<=499" (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO "orders_2 - price<=499" SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM ONLY orders;
DELETE 8
test_database=# \dt
                 List of relations
 Schema |         Name          | Type  |  Owner   
--------+-----------------------+-------+----------
 public | orders                | table | postgres
 public | orders_1 - price>499  | table | postgres
 public | orders_2 - price<=499 | table | postgres
(3 rows)

test_database=# 
```

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

Можно было прописать правила вставки, например:
```postgresql
CREATE RULE orders_insert_to_more AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO  "orders_1 - price>499" VALUES (NEW.*);
CREATE RULE orders_insert_to_less AS ON INSERT TO orders WHERE ( price <= 499 ) DO INSTEAD INSERT INTO "orders_2 - price<=499" VALUES (NEW.*);
```
Или использовать декларативное секционирование с предложением PARTITION BY

## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

---
