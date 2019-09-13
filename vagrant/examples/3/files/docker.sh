#!/bin/bash
##################################################
# Install Docker + Docker-compose                #
# Author by Dethroner, 2019                      #
##################################################

sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo apt-get -y install python-pip
sudo pip install docker-compose 