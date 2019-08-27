#!/bin/bash
##################################################
# Install Ansible                                #
# Author by Dethroner, 2019                      #
##################################################

echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/ansible.list
sudo apt install -y python dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install -y ansible
