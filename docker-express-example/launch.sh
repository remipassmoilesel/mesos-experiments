#!/usr/bin/env bash

set -x

./build.sh

docker run -p 80:80 --env-file <(sed -e 's/^/HOST_VAR_/' <(env)) node-sample