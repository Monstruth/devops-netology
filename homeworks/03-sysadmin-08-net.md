1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```

```
route-views>show ip route 31.135.187.xxx
Routing entry for 31.135.184.0/22
  Known via "bgp 6447", distance 20, metric 0
  Tag 3356, type external
  Last update from 4.68.4.46 2w2d ago
  Routing Descriptor Blocks:
  * 4.68.4.46, from 4.68.4.46, 2w2d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 3356
      MPLS label: none
```

```
route-views>show bgp 31.135.187.xxx
BGP routing table entry for 31.135.184.0/22, version 2564340932
Paths: (23 available, best #14, table default)
  Not advertised to any peer
  Refresh Epoch 1
  3333 31133 59595
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE0E022ADD0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 31133 59595
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE0ECA7D708 RPKI State valid
      rx pathid: 0, tx pathid: 0
```

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

```
monztro@monztro-laptop:~/Рабочий стол$ sudo modprobe -v dummy numdummies=2
insmod /lib/modules/5.15.0-53-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
monztro@monztro-laptop:~/Рабочий стол$ lsmod | grep dummy
dummy                  16384  0
monztro@monztro-laptop:~/Рабочий стол$ ifconfig -a | grep dummy
dummy0: flags=130<BROADCAST,NOARP>  mtu 1500
dummy1: flags=130<BROADCAST,NOARP>  mtu 1500
monztro@monztro-laptop:~/Рабочий стол$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:e0:4c:68:9b:4c brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.3/24 brd 192.168.0.255 scope global dynamic noprefixroute enp2s0
       valid_lft 44246sec preferred_lft 44246sec
    inet6 fe80::fb6c:c7ae:3c8c:dadc/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: wlp3s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 20:e5:2a:ff:18:fd brd ff:ff:ff:ff:ff:ff
4: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 22:04:5e:1a:30:9c brd ff:ff:ff:ff:ff:ff
5: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 62:31:d3:93:60:34 brd ff:ff:ff:ff:ff:ff
monztro@monztro-laptop:~/Рабочий стол$ sudo ip addr add 10.10.1.10/24 dev dummy0
monztro@monztro-laptop:~/Рабочий стол$ sudo ip addr add 10.10.1.11/24 dev dummy1
monztro@monztro-laptop:~/Рабочий стол$ sudo ip link set dev dummy0 up
monztro@monztro-laptop:~/Рабочий стол$ sudo ip link set dev dummy1 up
monztro@monztro-laptop:~/Рабочий стол$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:e0:4c:68:9b:4c brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.3/24 brd 192.168.0.255 scope global dynamic noprefixroute enp2s0
       valid_lft 83709sec preferred_lft 83709sec
    inet6 fe80::fb6c:c7ae:3c8c:dadc/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: wlp3s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 20:e5:2a:ff:18:fd brd ff:ff:ff:ff:ff:ff
4: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 22:04:5e:1a:30:9c brd ff:ff:ff:ff:ff:ff
    inet 10.10.1.10/24 scope global dummy0
       valid_lft forever preferred_lft forever
    inet6 fe80::2004:5eff:fe1a:309c/64 scope link 
       valid_lft forever preferred_lft forever
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 62:31:d3:93:60:34 brd ff:ff:ff:ff:ff:ff
    inet 10.10.1.11/24 scope global dummy1
       valid_lft forever preferred_lft forever
    inet6 fe80::6031:d3ff:fe93:6034/64 scope link 
       valid_lft forever preferred_lft forever
monztro@monztro-laptop:~/Рабочий стол$ ip -br a show
lo               UNKNOWN        127.0.0.1/8 ::1/128 
enp2s0           UP             192.168.0.3/24 fe80::fb6c:c7ae:3c8c:dadc/64 
wlp3s0           DOWN           
dummy0           UNKNOWN        10.10.1.10/24 fe80::2004:5eff:fe1a:309c/64 
dummy1           UNKNOWN        10.10.1.11/24 fe80::6031:d3ff:fe93:6034/64 
monztro@monztro-laptop:~/Рабочий стол$ sudo ip route add 8.8.4.4 via 192.168.0.4
monztro@monztro-laptop:~/Рабочий стол$ ip r
default via 192.168.0.1 dev enp2s0 proto dhcp metric 100 
8.8.4.4 via 192.168.0.4 dev enp2s0 
10.10.1.0/24 dev dummy0 proto kernel scope link src 10.10.1.10 
10.10.1.0/24 dev dummy1 proto kernel scope link src 10.10.1.11 
169.254.0.0/16 dev enp2s0 scope link metric 1000 
192.168.0.0/24 dev enp2s0 proto kernel scope link src 192.168.0.3 metric 100 
monztro@monztro-laptop:~/Рабочий стол$ 
```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```
sudo netstat -ntlp
Активные соединения с интернетом (only servers)
Proto Recv-Q Send-Q Local Address Foreign Address State       PID/Program name    
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init              
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      665/systemd-resolve 
tcp        0      0 127.0.0.1:9050          0.0.0.0:*               LISTEN      1001/tor            
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      949/cupsd           
tcp6       0      0 :::111                  :::*                    LISTEN      1/init              
tcp6       0      0 ::1:631                 :::*                    LISTEN      949/cupsd   
```

вторая строчка - 53 порт протокол tcp - Ubuntu использует systemd-resolved в качестве внутренней переадресации DNS.
systemd-resolved - это системная служба, которая обеспечивает разрешение сетевых имен для локальных приложений. Он реализует распознаватель заглушек DNS / DNSSEC для кэширования и проверки, а также распознаватель и ответчик LLMNR.

третья строчка - протокол tcp 9050 порт - слушает служба браузера TOR

четвертая строчка - 631 порт- слушает сервер печати Ubuntu

#### 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

