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



