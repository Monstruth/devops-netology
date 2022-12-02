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


