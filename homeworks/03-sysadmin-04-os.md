1

![101](https://user-images.githubusercontent.com/105611781/199496935-1339bb42-ea7b-46c9-9cee-4fd70d8637e1.PNG)

![102](https://user-images.githubusercontent.com/105611781/199496971-b2baa443-93a1-421a-a169-811c04193c32.PNG)

![103](https://user-images.githubusercontent.com/105611781/199497009-b1108884-4f6a-42bb-9eaf-7a8f460f690e.PNG)

на примере юнита cron
![106](https://user-images.githubusercontent.com/105611781/200078614-3edf1090-5502-495e-bc3d-09330d775687.PNG)
видим как
в файле /etc/default/cron прописываются сами значения переменных. Далее в unit-файле в разделе [Service] через EnvironmentFile указывается, откуда значения параметров забирать и после ExecStart указывается сам параметр через $:

EnvironmentFile=-/etc/default/cron

ExecStart=/usr/sbin/cron -f -P $EXTRA_OPTS

2

![104](https://user-images.githubusercontent.com/105611781/199497039-226e1d93-705a-43c1-b024-c0d9c24d6212.PNG)

![105](https://user-images.githubusercontent.com/105611781/199497085-c258b97e-de4a-4afd-9837-d1b28586a7ce.PNG)

3

![02](https://user-images.githubusercontent.com/105611781/199497428-9112eec1-a3f9-4567-8af2-9154a17d04f0.PNG)

4
