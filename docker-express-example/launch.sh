#!/usr/bin/env bash

set -x

docker rmi node-sample
docker build -t node-sample .
docker run -p 80:80 --env-file <(sed -e 's/^/HOST_VAR_/' <(env)) node-sample