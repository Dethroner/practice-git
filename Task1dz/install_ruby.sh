#!/bin/bash
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
/usr/local/rvm/bin/rvm requirements
/usr/local/rvm/bin/rvm install 2.4.1
/usr/local/rvm/bin/rvm use 2.4.1 --default
/usr/local/rvm/rubies/ruby-2.4.1/bin/gem install bundler -V --no-ri --no-rdoc
