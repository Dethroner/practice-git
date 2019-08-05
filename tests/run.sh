#!/bin/bash

docker exec -e USER=appuser hw-test bash -c 'apt-get update && apt-get install python3-pip -y && \
pip3 install -r tests/requirements.txt && \
/usr/bin/env py.test --version && ./tests/infra_tests.py -v'
