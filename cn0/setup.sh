#!/bin/bash
#
# setup.sh for ansible
#
dnf update -y
dnf upgrade -y
dnf install -y epel-release
dnf install -y make
dnf install -y git
dnf install -y python311
dnf install -y ansible
#
echo "ansible     ALL=(ALL)     NOPASSWD: ALL" > /etc/sudoers.d/ansible
useradd ansible
#
echo "=> check python"
python3 --version
echo "=> check ansible"
ansible --version

