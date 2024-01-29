#!/bin/bash
#
# create.sh
#
# ------------------------------------------------------------------------
cd cn0
sudo vagrant up 
cd ../cn1
sudo vagrant up 
cd ../cn2
sudo vagrant up 
cd  ../cn3
sudo vagrant up 
#
cd ..
./set_ssh.sh
#
#
cd cn1
IP1=$(sudo vagrant ssh -c 'exit' 2>&1  | awk '{print $3}')
cd ../cn2
IP2=$(sudo vagrant ssh -c 'exit' 2>&1  | awk '{print $3}')
cd ../cn3
IP3=$(sudo vagrant ssh -c 'exit' 2>&1  | awk '{print $3}')
#
cd ..
NEW_HOSTS=/tmp/new_hosts
echo "$IP1 cn1" > $NEW_HOSTS
echo "$IP2 cn2" >> $NEW_HOSTS
echo "$IP3 cn3" >> $NEW_HOSTS
cd cn0
sudo vagrant upload /tmp/new_hosts /tmp/new_hosts
sudo vagrant ssh -c "sudo su -c 'cat /tmp/new_hosts >> /etc/hosts'"
cd ../cn1
sudo vagrant upload /tmp/new_hosts /tmp/new_hosts
sudo vagrant ssh -c "sudo su -c 'cat /tmp/new_hosts >> /etc/hosts'"
cd ../cn2
sudo vagrant upload /tmp/new_hosts /tmp/new_hosts
sudo vagrant ssh -c "sudo su -c 'cat /tmp/new_hosts >> /etc/hosts'"
cd ../cn3 
sudo vagrant upload /tmp/new_hosts /tmp/new_hosts
sudo vagrant ssh -c "sudo su -c 'cat /tmp/new_hosts >> /etc/hosts'"
cd ..
#
sed  -e s/IP1/$IP1/g -e s/IP2/$IP2/g -e s/IP3/$IP3/g inventory.template > inventory
cp inventory /tmp/inventory
cd cn0
sudo vagrant upload /tmp/inventory /tmp/inventory
sudo vagrant ssh -c "sudo su - ansible -c 'git clone https://github.com/vitabaks/postgresql_cluster -b 1.8.0'"
sudo vagrant ssh -c "sudo su - ansible -c 'cp /tmp/inventory postgresql_cluster/.'"
sudo vagrant ssh -c "sudo su - ansible -c 'cd postgresql_cluster;ansible-playbook deploy_pgcluster.yml -i inventory'"
