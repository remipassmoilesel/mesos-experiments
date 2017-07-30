#!/usr/bin/env bash

set -x

docker rmi node-sample
docker build -t node-sample .
