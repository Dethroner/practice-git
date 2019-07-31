#!/bin/bash
git clone https://github.com/Artemmkin/reddit.git
cd reddit && /usr/local/rvm/gems/ruby-2.4.1/bin/bundle install
puma -d
ps aux | grep puma