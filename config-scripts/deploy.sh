#!/bin/bash

sudo -i
cd "$HOME" || exit
git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install && puma -d