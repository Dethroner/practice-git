#!/usr/bin/env bash

# Install ansible
echo "[Info] Install ansible..."
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# copy examples into /home/vagrant (from inside the master node)
cp -a /vagrant/files/ansible /home/appuser
chown -R appuser:appuser /home/appuser/ansible

# configure hosts file for internal network defined by Vagrantfile
cat /vagrant/files/ansible/node >> /etc/hosts
cat /vagrant/files/ansible/ansible.cfg > /etc/ansible/ansible.cfg