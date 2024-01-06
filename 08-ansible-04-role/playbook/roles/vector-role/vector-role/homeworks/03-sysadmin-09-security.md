1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

![01](https://user-images.githubusercontent.com/105611781/206421140-b2ba658d-1765-4916-b6cd-fc3519f2e54a.png)


2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

![02](https://user-images.githubusercontent.com/105611781/206421273-a5f2dcdb-d6de-414c-b7c0-eab449719b87.png)

![03](https://user-images.githubusercontent.com/105611781/206421335-baafbc69-ab89-46c2-aab4-c97d4409d923.png)


3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

```
vagrant@vagrant:~$ sudo systemctl restart apache2
vagrant@vagrant:~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
Generating a RSA private key
................................+++++
...+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Kaluga
Locality Name (eg, city) []:Maloyaroslavec
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Netology
Organizational Unit Name (eg, section) []:Netologia
Common Name (e.g. server FQDN or YOUR name) []:test.site
Email Address []:netology@netology.ru
vagrant@vagrant:~$ sudo nano /etc/apache2/sites-available/test.site.conf
vagrant@vagrant:~$ sudo mkdir /var/www/test.site
vagrant@vagrant:~$ sudo nano /var/www/test.site/index.html
vagrant@vagrant:~$ sudo a2ensite test.site.conf
Enabling site test.site.
To activate the new configuration, you need to run:
  systemctl reload apache2
vagrant@vagrant:~$ sudo apache2ctl configtest
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
vagrant@vagrant:~$ sudo systemctl reload apache2
vagrant@vagrant:~$ systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-12-08 12:03:45 UTC; 14s ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 1653 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
   Main PID: 1669 (apache2)
      Tasks: 55 (limit: 1066)
     Memory: 6.1M
     CGroup: /system.slice/apache2.service
             ├─1669 /usr/sbin/apache2 -k start
             ├─1670 /usr/sbin/apache2 -k start
             └─1671 /usr/sbin/apache2 -k start

Dec 08 12:03:45 vagrant systemd[1]: Starting The Apache HTTP Server...
Dec 08 12:03:45 vagrant apachectl[1666]: AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 1>
Dec 08 12:03:45 vagrant systemd[1]: Started The Apache HTTP Server.
```

![2022-12-08_15-27-52](https://user-images.githubusercontent.com/105611781/206446925-8a6275d7-541d-4c83-83e1-ecaa7e23d963.png)

чо то пишет что соединение небезопасное ((((


4. в процессе...



  
