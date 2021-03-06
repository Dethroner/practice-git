#! /bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get -y update
apt-get -y install mongodb-org ruby-full ruby-bundler build-essential
systemctl start mongod
systemctl enable mongod
cd "$HOME" || exit
git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install && puma -d