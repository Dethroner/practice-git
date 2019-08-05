#!/bin/bash
#GROUP=2019-05
BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}
HOMEWORK_RUN=./linting/tests/run.sh
REPO=https://github.com/sjay3/otus-homeworks.git
DOCKER_IMAGE=express42/otus-homeworks

#echo GROUP:$GROUP

# if [ "$BRANCH" == "" ]; then
# 	echo "We don't have tests for master branch"
# 	exit 0
# fi

echo HOMEWORK:$BRANCH
mkdir -p linting

echo "Clone repository with tests"
git clone $REPO linting/


if [ -f $HOMEWORK_RUN ]; then
	echo "Run tests"
	# Prepare network & run container
	docker network create hw-test-lint-net
	docker run -d -v $(pwd):/srv -v /var/run/docker.sock:/tmp/docker.sock \
		-e DOCKER_HOST=unix:///tmp/docker.sock --cap-add=NET_ADMIN -p 33533:22 --privileged \
		--device /dev/net/tun --name hw-test-lint --network hw-test-lint-net $DOCKER_IMAGE
	# Show versions & run tests
	docker exec hw-test-lint bash -c 'echo -=Get versions=-; ansible --version; ansible-lint --version; packer version; terraform version; tflint --version; docker version; docker-compose --version'
	#docker exec hw-test-lint bash -c 'pwd; id'
	docker exec -e USER=appuser -e BRANCH=$BRANCH hw-test-lint $HOMEWORK_RUN

	# ssh -i id_rsa_test -p 33433 root@localhost "cd /srv && BRANCH=$BRANCH $HOMEWORK_RUN"
else
	echo "We don't have tests for this homework"
	exit 0
fi