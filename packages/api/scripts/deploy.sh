#!/bin/bash
set -e
export $(cat ./scripts/.env | xargs)
docker build -t andre/codequettish-api:$npm_package_version .
docker save andre/codequettish-api:$npm_package_version | bzip2 | ssh $SSH_USER@$SSH_HOST "bunzip2 | docker load"
ssh $SSH_USER@$SSH_HOST "docker tag andre/codequettish-api:$(echo $npm_package_version) dokku/api:latest && dokku tags:deploy api latest"
