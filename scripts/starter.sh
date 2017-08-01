#!/usr/bin/env bash

apt-get update
apt-get install -y git curl vim

cd /root && git clone https://github.com/remipassmoilesel/mesos-experiments.git