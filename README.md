##Первоначальная настройка k8s

sudo su;  - заходим под root

apt update

systemctl stop ufw - отключаем файрвол
systemctl disable ufw- выключаем файрвол
swapoff -a  - отключаем swap 

free -h - проверяем что swap отключен 

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab -  комментируем строку , чтобы после перезагрузки сохранились изменения 

sudo nano /etc/modules-load.d/containerd.conf  - создаем файл и записываем переменные 

overlay
br_netfilter

![Untitled](https://github.com/Rizikkz/k8s-django/blob/main/image/Untitled.png)

сохраняем и выходим.

Затем с помощью команды modprobe добавьте модули:

sudo modprobe overlay

sudo modprobe br_netfilter

Откройте файл kubernetes.conf, чтобы настроить работу сети Kubernetes:

sudo nano /etc/sysctl.d/kubernetes.conf

Добавьте в файл следующие строки

net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1

![Untitled](https://github.com/Rizikkz/k8s-django/blob/main/image/Untitled%20(1).png)

Перезагрузите конфигурацию, набрав :

sudo sysctl --system
