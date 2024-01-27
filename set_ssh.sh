#/bin/bash
#
# set_ssh.sh
#
# ---------------------------------------------------------------------------------------------

function set_ssh_auth () {

sudo vagrant upload /tmp/id_rsa.pub /tmp/id_rsa.pub
sudo vagrant ssh -c "sudo su - ansible -c 'rm -rf .ssh'" 
sudo vagrant ssh -c "sudo su - ansible -c 'mkdir .ssh'" 
sudo vagrant ssh -c "sudo su - ansible -c 'chmod og-rwx .ssh'" 
sudo vagrant ssh -c "sudo su - ansible -c 'cp /tmp/id_rsa.pub .ssh/authorized_keys'" 
sudo vagrant ssh -c "sudo su - ansible -c 'chmod og-rwx .ssh/authorized_keys'"
#
sudo vagrant upload /tmp/config /tmp/config
sudo vagrant ssh -c "sudo su - ansible -c 'cp /tmp/config .ssh/.'"
sudo vagrant ssh -c "sudo su - ansible -c 'chmod 644 .ssh/config'"
#
sudo vagrant ssh -c "sudo su -c 'sed -i /etc/ssh/sshd_config -e s/HostKey/#HostKey/'"
sudo vagrant ssh -c "sudo su -c 'systemctl restart sshd'"

}
echo "Host *" > /tmp/config
echo "    StrictHostKeyChecking No" >> /tmp/config
##
cd cn0
sudo vagrant ssh -c "sudo su - ansible -c 'rm -rf .ssh'"
sudo vagrant ssh -c "sudo su - ansible -c 'ssh-keygen -q -N \"\" -f /home/ansible/.ssh/id_rsa'"
sudo vagrant ssh -c "sudo su - ansible -c 'cat /home/ansible/.ssh/id_rsa.pub'" > /tmp/id_rsa.pub
#
sudo vagrant upload /tmp/config /tmp/config
sudo vagrant ssh -c "sudo su - ansible -c 'cp /tmp/config .ssh/.'"
sudo vagrant ssh -c "sudo su - ansible -c 'chmod 644 .ssh/config'"
#
sudo vagrant ssh -c "sudo su -c 'sed -i /etc/ssh/sshd_config -e s/HostKey/#HostKey/'"
sudo vagrant ssh -c "sudo su -c 'systemctl restart sshd'"
##
cd ../cn1
set_ssh_auth
##
cd ../cn2
set_ssh_auth
##
cd ../cn3
set_ssh_auth
