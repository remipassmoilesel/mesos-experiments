#!/usr/bin/env bash

apt-get update
apt-get install -y git curl vim

cd /root && git clone https://github.com/remipassmoilesel/mesos-experiments.git

# wget -q -O - https://raw.githubusercontent.com/remipassmoilesel/mesos-experiments/master/scripts/starter.sh | bash
