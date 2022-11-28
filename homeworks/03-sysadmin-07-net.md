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
в Windows команда ifconfig

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


