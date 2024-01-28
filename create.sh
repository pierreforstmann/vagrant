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
NEW_HOSTS=/tmp/hosts.$$
echo "$IP1 cn1" > $NEW_HOSTS
echo "$IP2 cn2" >> $NEW_HOSTS
echo "$IP3 cn3" >> $NEW_HOSTS
sed -i s/IP1/$IP1/g inventory
sed -i s/IP2/$IP2/g inventory
sed -i s/IP3/$IP3/g inventory
#
cp inventory /tmp/inventory
cd cn0
sudo vagrant upload /tmp/inventory /tmp/inventory
