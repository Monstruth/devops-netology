1

```
monztro@monztro-laptop:~/Рабочий стол$ ip -c -br l
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
enp2s0           UP             00:e0:4c:68:9b:4c <BROADCAST,MULTICAST,UP,LOWER_UP> 
wlp3s0           DOWN           20:e5:2a:ff:18:fd <BROADCAST,MULTICAST> 
monztro@monztro-laptop:~/Рабочий стол$ ls /sys/class/net
enp2s0  lo  wlp3s0
monztro@monztro-laptop:~/Рабочий стол$ ifconfig -a
enp2s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.3  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::fb6c:c7ae:3c8c:dadc  prefixlen 64  scopeid 0x20<link>
        ether 00:e0:4c:68:9b:4c  txqueuelen 1000  (Ethernet)
        RX packets 6924850  bytes 8983414431 (8.9 GB)
        RX errors 0  dropped 20  overruns 0  frame 0
        TX packets 4621587  bytes 625907225 (625.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Локальная петля (Loopback))
        RX packets 10087  bytes 1980754 (1.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10087  bytes 1980754 (1.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlp3s0: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 20:e5:2a:ff:18:fd  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 19  

monztro@monztro-laptop:~/Рабочий стол$ nmcli device status
DEVICE  TYPE      STATE          CONNECTION             
enp2s0  ethernet  подключено     Проводное соединение 1 
wlp3s0  wifi      недоступно     --                     
lo      loopback  не настроенно  --                     
monztro@monztro-laptop:~/Рабочий стол$ netstat -i
Таблица интерфейсов ядра
Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
enp2s0    1500  6927927      0     20 0       4623712      0      0      0 BMRU
lo       65536    10095      0      0 0         10095      0      0      0 LRU
monztro@monztro-laptop:~/Рабочий стол$ cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo: 1983048   10097    0    0    0     0          0         0  1983048   10097    0    0    0     0       0          0
enp2s0: 8988509490 6928868    0   20    0     0          0      1554 626127200 4624335    0    0    0     0       0          0
wlp3s0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
monztro@monztro-laptop:~/Рабочий стол$ 
```
в Windows - `ipconfig` или `netsh interface ip show interfaces`

2

Link Layer Discovery Protocol (LLDP) — протокол канального уровня, позволяющий сетевому оборудованию оповещать оборудование, работающее в локальной сети, о своём существовании и передавать ему свои характеристики, а также получать от него аналогичные сведения. Информация, собранная посредством LLDP, накапливается в устройствах и может быть с них запрошена посредством SNMP. 
Пакет lldpd. Команда lldpctl.

3

Технология называется VLAN (Virtual LAN).
Пакет в Ubuntu Linux - vlan

```
vagrant@vagrant:~$ sudo ip link add link eth0 name eth0.10 type vlan id 10
vagrant@vagrant:~$ sudo ip -d link show eth0.10
3: eth0.10@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 0 maxmtu 65535
    vlan protocol 802.1Q id 10 <REORDER_HDR> addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
vagrant@vagrant:~$ sudo ip addr add 192.168.1.200/24 brd 192.168.1.255 dev eth0.10
vagrant@vagrant:~$ sudo ip link set dev eth0.10 up
vagrant@vagrant:~$ ip -c l
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
3: eth0.10@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
vagrant@vagrant:~$
```

4

Bonding – это объединение сетевых интерфейсов по определенному типу агрегации, Служит для увеличения пропускной способности и/или отказоустойчивость сети.

Типы агрегации интерфейсов в Linux:

Mode-0(balance-rr) – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся. Дополнительной настройки коммутатора не требуется при нахождении портов в одном коммутаторе. При разностных коммутаторах требуется дополнительная настройка.

Mode-1(active-backup) – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы на активном интерфейсе производится переключение на ожидающий интерфейс. Не требуется поддержки от коммутатора.

Mode-2(balance-xor) – Передача пакетов распределяется по типу входящего и исходящего трафика по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. Не требуется дополнительной настройки коммутатора/коммутаторов.

Mode-3(broadcast) – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. Рекомендуется только для использования MULTICAST трафика.

Mode-4(802.3ad) – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную способность входящего так и исходящего трафика. Для данного режима необходима поддержка и настройка коммутатора/коммутаторов.

Mode-5(balance-tlb) – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

Mode-6(balance-alb) – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

создал через вагрант файл две дополнительные сетевые карты

```
vagrant@vagrant:~$ sudo modprobe bonding
vagrant@vagrant:~$ lsmod | grep bond
bonding               167936  0
vagrant@vagrant:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 84484sec preferred_lft 84484sec
    inet6 fe80::a00:27ff:fea2:6bfd/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:a2:9d:fc brd ff:ff:ff:ff:ff:ff
    inet 192.168.9.10/24 brd 192.168.9.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fea2:9dfc/64 scope link
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:f2:fb:af brd ff:ff:ff:ff:ff:ff
    inet 192.168.33.10/24 brd 192.168.33.255 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fef2:fbaf/64 scope link
       valid_lft forever preferred_lft forever
vagrant@vagrant:~$ sudo ip link set eth1 down
vagrant@vagrant:~$ sudo ip link set eth2 down
vagrant@vagrant:~$ ip -c l
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:9d:fc brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:f2:fb:af brd ff:ff:ff:ff:ff:ff
vagrant@vagrant:~$ sudo ip link add bond0 type bond mode 802.3ad
vagrant@vagrant:~$ sudo ip link set eth1 master bond0
vagrant@vagrant:~$ sudo ip link set eth2 master bond0
vagrant@vagrant:~$ sudo ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc fq_codel master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:9d:fc brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc fq_codel master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:9d:fc brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:9d:fc brd ff:ff:ff:ff:ff:ff
vagrant@vagrant:~$
```

5

```ipcalc -b 10.10.10.0/29
Address:   10.10.10.0           
Netmask:   255.255.255.248 = 29 
Wildcard:  0.0.0.7              
=>
Network:   10.10.10.0/29        
HostMin:   10.10.10.1           
HostMax:   10.10.10.6           
Broadcast: 10.10.10.7           
Hosts/Net: 6                     Class A, Private Internet
```
всего 8 адресов, из них 6 узловых

```
ipcalc -b 10.10.10.0/24 /29
Address:   10.10.10.0           
Netmask:   255.255.255.0 = 24   
Wildcard:  0.0.0.255            
=>
Network:   10.10.10.0/24        
HostMin:   10.10.10.1           
HostMax:   10.10.10.254         
Broadcast: 10.10.10.255         
Hosts/Net: 254                   Class A, Private Internet

Subnets after transition from /24 to /29

Netmask:   255.255.255.248 = 29 
Wildcard:  0.0.0.7              

 1.
Network:   10.10.10.0/29        
HostMin:   10.10.10.1           
HostMax:   10.10.10.6           
Broadcast: 10.10.10.7           
Hosts/Net: 6                     Class A, Private Internet

 2.
Network:   10.10.10.8/29        
HostMin:   10.10.10.9           
HostMax:   10.10.10.14          
Broadcast: 10.10.10.15          
Hosts/Net: 6                     Class A, Private Internet

 3.
Network:   10.10.10.16/29       
HostMin:   10.10.10.17          
HostMax:   10.10.10.22          
Broadcast: 10.10.10.23          
Hosts/Net: 6                     Class A, Private Internet

 4.
Network:   10.10.10.24/29       
HostMin:   10.10.10.25          
HostMax:   10.10.10.30          
Broadcast: 10.10.10.31          
Hosts/Net: 6                     Class A, Private Internet

 5.
Network:   10.10.10.32/29       
HostMin:   10.10.10.33          
HostMax:   10.10.10.38          
Broadcast: 10.10.10.39          
Hosts/Net: 6                     Class A, Private Internet

 6.
Network:   10.10.10.40/29       
HostMin:   10.10.10.41          
HostMax:   10.10.10.46          
Broadcast: 10.10.10.47          
Hosts/Net: 6                     Class A, Private Internet

 7.
Network:   10.10.10.48/29       
HostMin:   10.10.10.49          
HostMax:   10.10.10.54          
Broadcast: 10.10.10.55          
Hosts/Net: 6                     Class A, Private Internet

 8.
Network:   10.10.10.56/29       
HostMin:   10.10.10.57          
HostMax:   10.10.10.62          
Broadcast: 10.10.10.63          
Hosts/Net: 6                     Class A, Private Internet

 9.
Network:   10.10.10.64/29       
HostMin:   10.10.10.65          
HostMax:   10.10.10.70          
Broadcast: 10.10.10.71          
Hosts/Net: 6                     Class A, Private Internet

 10.
Network:   10.10.10.72/29       
HostMin:   10.10.10.73          
HostMax:   10.10.10.78          
Broadcast: 10.10.10.79          
Hosts/Net: 6                     Class A, Private Internet

 11.
Network:   10.10.10.80/29       
HostMin:   10.10.10.81          
HostMax:   10.10.10.86          
Broadcast: 10.10.10.87          
Hosts/Net: 6                     Class A, Private Internet

 12.
Network:   10.10.10.88/29       
HostMin:   10.10.10.89          
HostMax:   10.10.10.94          
Broadcast: 10.10.10.95          
Hosts/Net: 6                     Class A, Private Internet

 13.
Network:   10.10.10.96/29       
HostMin:   10.10.10.97          
HostMax:   10.10.10.102         
Broadcast: 10.10.10.103         
Hosts/Net: 6                     Class A, Private Internet

 14.
Network:   10.10.10.104/29      
HostMin:   10.10.10.105         
HostMax:   10.10.10.110         
Broadcast: 10.10.10.111         
Hosts/Net: 6                     Class A, Private Internet

 15.
Network:   10.10.10.112/29      
HostMin:   10.10.10.113         
HostMax:   10.10.10.118         
Broadcast: 10.10.10.119         
Hosts/Net: 6                     Class A, Private Internet

 16.
Network:   10.10.10.120/29      
HostMin:   10.10.10.121         
HostMax:   10.10.10.126         
Broadcast: 10.10.10.127         
Hosts/Net: 6                     Class A, Private Internet

 17.
Network:   10.10.10.128/29      
HostMin:   10.10.10.129         
HostMax:   10.10.10.134         
Broadcast: 10.10.10.135         
Hosts/Net: 6                     Class A, Private Internet

 18.
Network:   10.10.10.136/29      
HostMin:   10.10.10.137         
HostMax:   10.10.10.142         
Broadcast: 10.10.10.143         
Hosts/Net: 6                     Class A, Private Internet

 19.
Network:   10.10.10.144/29      
HostMin:   10.10.10.145         
HostMax:   10.10.10.150         
Broadcast: 10.10.10.151         
Hosts/Net: 6                     Class A, Private Internet

 20.
Network:   10.10.10.152/29      
HostMin:   10.10.10.153         
HostMax:   10.10.10.158         
Broadcast: 10.10.10.159         
Hosts/Net: 6                     Class A, Private Internet

 21.
Network:   10.10.10.160/29      
HostMin:   10.10.10.161         
HostMax:   10.10.10.166         
Broadcast: 10.10.10.167         
Hosts/Net: 6                     Class A, Private Internet

 22.
Network:   10.10.10.168/29      
HostMin:   10.10.10.169         
HostMax:   10.10.10.174         
Broadcast: 10.10.10.175         
Hosts/Net: 6                     Class A, Private Internet

 23.
Network:   10.10.10.176/29      
HostMin:   10.10.10.177         
HostMax:   10.10.10.182         
Broadcast: 10.10.10.183         
Hosts/Net: 6                     Class A, Private Internet

 24.
Network:   10.10.10.184/29      
HostMin:   10.10.10.185         
HostMax:   10.10.10.190         
Broadcast: 10.10.10.191         
Hosts/Net: 6                     Class A, Private Internet

 25.
Network:   10.10.10.192/29      
HostMin:   10.10.10.193         
HostMax:   10.10.10.198         
Broadcast: 10.10.10.199         
Hosts/Net: 6                     Class A, Private Internet

 26.
Network:   10.10.10.200/29      
HostMin:   10.10.10.201         
HostMax:   10.10.10.206         
Broadcast: 10.10.10.207         
Hosts/Net: 6                     Class A, Private Internet

 27.
Network:   10.10.10.208/29      
HostMin:   10.10.10.209         
HostMax:   10.10.10.214         
Broadcast: 10.10.10.215         
Hosts/Net: 6                     Class A, Private Internet

 28.
Network:   10.10.10.216/29      
HostMin:   10.10.10.217         
HostMax:   10.10.10.222         
Broadcast: 10.10.10.223         
Hosts/Net: 6                     Class A, Private Internet

 29.
Network:   10.10.10.224/29      
HostMin:   10.10.10.225         
HostMax:   10.10.10.230         
Broadcast: 10.10.10.231         
Hosts/Net: 6                     Class A, Private Internet

 30.
Network:   10.10.10.232/29      
HostMin:   10.10.10.233         
HostMax:   10.10.10.238         
Broadcast: 10.10.10.239         
Hosts/Net: 6                     Class A, Private Internet

 31.
Network:   10.10.10.240/29      
HostMin:   10.10.10.241         
HostMax:   10.10.10.246         
Broadcast: 10.10.10.247         
Hosts/Net: 6                     Class A, Private Internet

 32.
Network:   10.10.10.248/29      
HostMin:   10.10.10.249         
HostMax:   10.10.10.254         
Broadcast: 10.10.10.255         
Hosts/Net: 6                     Class A, Private Internet


Subnets:   32
Hosts:     192
```

Сеть с маской /24 можно разбить на 32 подсети с маской /29

6

100.64.0.0 — 100.127.255.255 (маска подсети 255.192.0.0 или /10)
Данная подсеть рекомендована согласно RFC 6598 для использования в качестве адресов для CGN

```
ipcalc -b 100.64.0.0/10 -s 50
Address:   100.64.0.0           
Netmask:   255.192.0.0 = 10     
Wildcard:  0.63.255.255         
=>
Network:   100.64.0.0/10        
HostMin:   100.64.0.1           
HostMax:   100.127.255.254      
Broadcast: 100.127.255.255      
Hosts/Net: 4194302               Class A

1. Requested size: 50 hosts
Netmask:   255.255.255.224 = 27 
Network:   100.64.0.0/27        
HostMin:   100.64.0.1           
HostMax:   100.64.0.30          
Broadcast: 100.64.0.31          
Hosts/Net: 30                    Class A

Needed size:  64 addresses.
Used network: 100.64.0.0/26
Unused:
100.64.0.64/26
100.64.0.128/25
100.64.1.0/24
100.64.2.0/23
100.64.4.0/22
100.64.8.0/21
100.64.16.0/20
100.64.32.0/19
100.64.64.0/18
100.64.128.0/17
100.65.0.0/16
100.66.0.0/15
100.68.0.0/14
100.72.0.0/13
100.80.0.0/12
100.96.0.0/11
```

7

В Windows и Linux посмотреть таблицу можно командой `arp -a`

