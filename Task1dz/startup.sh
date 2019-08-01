#!/bin/bash
wget https://github.com/Dethroner/practice-git/blob/master/Task1dz/Deploy.tar
tar -xvf Deploy.tar
cd Deploy
bash install_ruby.sh
bash install_mongodb.sh
bash deploy.sh