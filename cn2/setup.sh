#!/bin/bash
#
# setup.sh for ansible
#
hostnamectl set-hostname cn2
echo "=> check hostname"
hostname
echo "check /etc/hostname"
cat /etc/hostname
#
dnf update -y
dnf upgrade -y
dnf install -y epel-release
dnf install -y make
dnf install -y git
dnf install -y python311
#
echo "ansible     ALL=(ALL)     NOPASSWD: ALL" > /etc/sudoers.d/ansible
useradd ansible
#
echo "=> check python"
python3 --version
#
#nmcli connect modify "System eth1" ipv4.gateway 192.168.121.1
#nmcli connection down "System eth1"
#nmcli connection up "System eth1"
#nmcli connection modify eth0 ipv4.never-default yes
#nmcli connection down eth0
#nmcli connection up eth0
#reboot

