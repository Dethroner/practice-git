#!/bin/bash
git clone https://github.com/Artemmkin/reddit.git
cd reddit && sudo bundle install
puma -d
ps aux | grep puma