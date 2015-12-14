#!/usr/bin/env bash

# Configuration Files
cp /vagrant/etc/hosts /etc/hosts
cp /vagrant/etc/resolv.conf /etc/resolv.conf

# Root
usermod --password hadoop root
mkdir -p /root/.ssh; chmod 600 /root/.ssh; cp /home/vagrant/.ssh/authorized_keys /root/.ssh/
cp /vagrant/root/.bashrc /root/.bashrc

# Increasing swap space
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab

# NTP
yum install -y ntp
service ntpd start

# Docker
wget -qO- https://get.docker.com/ | sh
service docker start
usermod -aG docker vagrant

# Ambari-Server
curl -Lo /root/ambari-functions https://raw.githubusercontent.com/freygrob/docker-ambari/master/ambari-functions
source /root/ambari-functions

amb-start-first

eval $(amb-settings)
iptables -t nat -A DOCKER -p tcp --dport 8080 -j DNAT --to-destination ${AMBARI_SERVER_IP}:8080
