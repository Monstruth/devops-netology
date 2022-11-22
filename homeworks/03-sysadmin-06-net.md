1

```
monztro@monztro-laptop:~/Рабочий стол$ telnet stackoverflow.com 80
Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 403 Forbidden
Connection: close
Content-Length: 1921
Server: Varnish
Retry-After: 0
Content-Type: text/html
Accept-Ranges: bytes
Date: Tue, 22 Nov 2022 09:23:22 GMT
Via: 1.1 varnish
X-Served-By: cache-hhn4070-HHN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1669109003.994028,VS0,VE1
X-DNS-Prefetch-Control: off

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Forbidden - Stack Exchange</title>
    <style type="text/css">
		body
		{
			color: #333;
			font-family: 'Helvetica Neue', Arial, sans-serif;
			font-size: 14px;
			background: #fff url('img/bg-noise.png') repeat left top;
			line-height: 1.4;
		}
		h1
		{
			font-size: 170%;
			line-height: 34px;
			font-weight: normal;
		}
		a { color: #366fb3; }
		a:visited { color: #12457c; }
		.wrapper {
			width:960px;
			margin: 100px auto;
			text-align:left;
		}
		.msg {
			float: left;
			width: 700px;
			padding-top: 18px;
			margin-left: 18px;
		}
    </style>
</head>
<body>
    <div class="wrapper">
		<div style="float: left;">
			<img src="https://cdn.sstatic.net/stackexchange/img/apple-touch-icon.png" alt="Stack Exchange" />
		</div>
		<div class="msg">
			<h1>Access Denied</h1>
                        <p>This IP address (31.135.187.229) has been blocked from access to our services. If you believe this to be in error, please contact us at <a href="mailto:team@stackexchange.com?Subject=Blocked%2031.135.187.229%20(Request%20ID%3A%20613996889-HHN)">team@stackexchange.com</a>.</p>
                        <p>When contacting us, please include the following information in the email:</p>
                        <p>Method: block</p>
                        <p>XID: 613996889-HHN</p>
                        <p>IP: 31.135.187.229</p>
                        <p>X-Forwarded-For: </p>
                        <p>User-Agent: </p>
                        
                        <p>Time: Tue, 22 Nov 2022 09:23:22 GMT</p>
                        <p>URL: stackoverflow.com/questions</p>
                        <p>Browser Location: <span id="jslocation">(not loaded)</span></p>
		</div>
	</div>
	<script>document.getElementById('jslocation').innerHTML = window.location.href;</script>
</body>
</html>Connection closed by foreign host.
```
ошибка 403 сервер отказал в доступе по моему IP , видимо доступ из России запрещён или ещё какая то причина, например сделана защита от ddos атак

Поэтому пробуем подключится к яндексу:
```
telnet yandex.ru 80
Trying 5.255.255.5...
Connected to yandex.ru.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: yandex.ru

HTTP/1.1 302 Moved temporarily
Content-Length: 0
Location: https://yandex.ru/questions
NEL: {"report_to": "network-errors", "max_age": 100, "success_fraction": 0.001, "failure_fraction": 0.1}
Report-To: { "group": "network-errors", "max_age": 100, "endpoints": [{"url": "https://dr.yandex.net/nel", "priority": 1}, {"url": "https://dr2.yandex.net/nel", "priority": 2}]}
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
set-cookie: is_gdpr=0; Path=/; Domain=.yandex.ru; Expires=Thu, 21 Nov 2024 09:36:59 GMT
set-cookie: is_gdpr_b=CMyzPRDslgE=; Path=/; Domain=.yandex.ru; Expires=Thu, 21 Nov 2024 09:36:59 GMT
set-cookie: _yasc=fRORKSrlS8oDVlmiJdVEGJfw07evg1935NCMxo2VAMWk66qYKwKbkITPnQU36A==; domain=.yandex.ru; path=/; expires=Fri, 19-Nov-2032 09:36:59 GMT; secure

Connection closed by foreign host.
```
302 Данный код статуса сообщает клиенту, что ресурс временно доступен по другому URI, указанному в строке заголовка Location, заголовка ответа сервера. Как я понял этот код здесь нам говорит что ресурс работает по протоколу https

2

![02](https://user-images.githubusercontent.com/105611781/203297325-4c27a232-8082-4b09-817d-a372eeb7b14f.png)

307 Redirect — Временное перенаправление
Запрошенный ресурс временно доступен по URI, указанному в строке заголовка Location, заголовка ответа сервера. Опять нас перенаправляют на HTTPS

![03](https://user-images.githubusercontent.com/105611781/203301379-f4ced7ce-7114-4025-8f2b-2d4a1b2f1695.png)

Load: 2.23 s - время загрузки страницы

![04](https://user-images.githubusercontent.com/105611781/203302845-38b9993c-6998-4979-9876-f37e8b0d87fb.png)

самый длинный запрос аналитика analytics.js - 680 миллисекунд

3

```
dig @resolver4.opendns.com myip.opendns.com +short
31.135.187.xxx
```
4

```
whois 31.135.187.xxx
% This is the RIPE Database query service.
% The objects are in RPSL format.
%
% The RIPE Database is subject to Terms and Conditions.
% See http://www.ripe.net/db/support/db-terms-conditions.pdf

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '31.135.184.0 - 31.135.191.255'

% Abuse contact for '31.135.184.0 - 31.135.191.255' is 'romannix@mail.ru'

inetnum:        31.135.184.0 - 31.135.191.255
netname:        TENETATELEKOM
country:        RU
org:            ORG-TENE1-RIPE
admin-c:        AI2981-RIPE
tech-c:         AI2981-RIPE
status:         ASSIGNED PI
mnt-by:         RIPE-NCC-END-MNT
mnt-by:         TENETATELEKOM-MNT
mnt-routes:     TENETATELEKOM-MNT
mnt-domains:    TENETATELEKOM-MNT
created:        2012-08-09T10:02:43Z
last-modified:  2016-04-14T09:08:18Z
source:         RIPE # Filtered
sponsoring-org: ORG-Vs35-RIPE

organisation:   ORG-TENE1-RIPE
org-name:       Teneta Telekom Ltd.
org-type:       OTHER
country:        RU
address:        Kaluzhskaya oblast, g.Maloyaroslavets, ul. Moskovskaya, d.16. ofis 200
abuse-c:        AR20399-RIPE
mnt-ref:        TENETATELEKOM-MNT
mnt-by:         TENETATELEKOM-MNT
created:        2012-08-06T13:13:37Z
last-modified:  2022-10-31T14:41:06Z
source:         RIPE # Filtered

person:         Grigorov Roman
address:        16 Moskovskaya st., Maloyaroslavec, Kaluga region, Russia
phone:          +79206146368
nic-hdl:        AI2981-RIPE
mnt-by:         TENETATELEKOM-MNT
created:        2012-08-06T13:12:09Z
last-modified:  2016-09-01T07:41:33Z
source:         RIPE # Filtered

% Information related to '31.135.184.0/22AS59595'

route:          31.135.184.0/22
origin:         AS59595
mnt-by:         TENETATELEKOM-MNT
created:        2021-03-03T17:21:45Z
last-modified:  2021-03-03T17:21:45Z
source:         RIPE

% This query was served by the RIPE Database Query Service version 1.104 (HEREFORD)
```

Провайдер - Тенетателеком. AS59595.

5

```
traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  192.168.0.1 [*]  0.357 ms  0.440 ms  0.516 ms
 2  172.31.240.2 [*]  3.522 ms  3.588 ms  3.569 ms
 3  31.135.191.177 [AS59595]  4.067 ms  4.205 ms  4.186 ms
 4  217.150.47.30 [AS20485]  6.241 ms  6.341 ms  6.417 ms
 5  * * *
 6  188.43.29.2 [AS20485]  17.250 ms 188.43.31.186 [AS20485]  4.663 ms 188.43.29.2 [AS20485]  19.078 ms
 7  188.43.245.41 [AS20485]  19.661 ms  14.707 ms 188.43.30.129 [AS20485]  5.538 ms
 8  * * *
 9  188.43.10.141 [AS20485]  8.901 ms  18.717 ms  18.702 ms
10  108.170.250.130 [AS15169]  20.306 ms 108.170.250.99 [AS15169]  10.238 ms 108.170.250.146 [AS15169]  10.638 ms
11  172.253.66.116 [AS15169]  34.203 ms 142.250.239.64 [AS15169]  30.911 ms 142.251.238.82 [AS15169]  29.038 ms
12  142.250.235.62 [AS15169]  28.069 ms 72.14.232.76 [AS15169]  21.227 ms 142.250.235.68 [AS15169]  22.679 ms
13  172.253.51.245 [AS15169]  18.596 ms 172.253.51.247 [AS15169]  25.146 ms 216.239.46.139 [AS15169]  32.608 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  8.8.8.8 [AS15169]  28.191 ms  21.245 ms *
```
Первый узел это мой роутер, второй узел это машрутизатор провайдера. Потом идут AS - AS59595, AS20485 и AS15169.

6

```
mtr 8.8.8.8 -znrc 1
Start: 2022-11-22T15:31:26+0300
HOST: monztro-laptop              Loss%   Snt   Last   Avg  Best  Wrst StDev
  1. AS???    192.168.0.1          0.0%     1    0.5   0.5   0.5   0.5   0.0
  2. AS???    172.31.240.2         0.0%     1    1.4   1.4   1.4   1.4   0.0
  3. AS59595  31.135.191.177       0.0%     1    2.1   2.1   2.1   2.1   0.0
  4. AS20485  217.150.47.30        0.0%     1    4.6   4.6   4.6   4.6   0.0
  5. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
  6. AS20485  188.43.30.42         0.0%     1   13.7  13.7  13.7  13.7   0.0
  7. AS20485  188.43.245.41        0.0%     1   14.3  14.3  14.3  14.3   0.0
  8. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
  9. AS20485  188.43.10.141        0.0%     1   18.4  18.4  18.4  18.4   0.0
 10. AS15169  108.170.250.34       0.0%     1   18.4  18.4  18.4  18.4   0.0
 11. AS15169  142.251.238.82       0.0%     1   29.0  29.0  29.0  29.0   0.0
 12. AS15169  142.251.238.72       0.0%     1   29.0  29.0  29.0  29.0   0.0
 13. AS15169  216.239.49.3         0.0%     1   30.6  30.6  30.6  30.6   0.0
 14. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 15. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 16. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 17. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 18. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 19. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 20. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 21. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 22. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 23. AS15169  8.8.8.8              0.0%     1   28.3  28.3  28.3  28.3   0.0
 ```
 
 наибольшая задержка на 13 узле
 
 7
 
 
