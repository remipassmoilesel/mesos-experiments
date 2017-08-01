#!/usr/bin/env bash

# Activate debug
set -x

. ./config.sh

echo "Setting up master with address:             ${MASTER_ADDRESS}"
echo "Setting up master with host name:           ${MASTER_HOST_NAME}"

export DEBIANFRONTEND=noninteractive

# Add the mesosphere repository and update index
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
export DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
export CODENAME=$(lsb_release -cs)

echo "deb http://ftp.de.debian.org/debian jessie-backports main contrib non-free"    | tee /etc/apt/sources.list.d/backports.list
echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main"   | tee /etc/apt/sources.list.d/mesosphere.list

# Update all
apt-get update -y
apt-get upgrade -y

# Install java 8
apt-get install -y openjdk-8-jre -t jessie-backports

# Fix locale for french (WIP)
# echo -e 'LANG="fr_FR.UTF-8"\nLANGUAGE="fr_FR:fr"\nLC_ALL="fr_FR"\nLC_TYPE="fr_FR.UTF-8"\n' > /etc/default/locale
# echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
# dpkg-reconfigure -f noninteractive locales

# Add various helpers
apt-get install -y vim byobu curl wget openssh-server ranger zsh git sed htop

# Add oh my zsh for root
cd /root && git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
cp /root/mesos-experiments/scripts/common-files/zshrc /root/.zshrc
chsh -s /bin/zsh

# Change root password
# echo root:qwerty | chpasswd

##
## INSTALL MESOS
##

# Install Mesos and frameworks
apt-get install -y mesos marathon chronos
apt-get install -y zookeeper zookeeperd
apt-get install -y haproxy haproxy-doc

# Install Docker
curl -fsSL get.docker.com | sh

# Add docker group to vagrant user
usermod -aG docker debian

# install python pip and update it
apt-get install -y python-pip -t jessie-backports
pip install pip --upgrade

# install mesos cli and docker compose
pip install docker-compose
pip install mesos.cli

# Add startup script (TODO: use System V)
cp /root/mesos-experiments/scripts/master-files/rc.local /etc/rc.local
chmod +x /etc/rc.local

# Enable haproxy / marathon bridge for load balancing
/root/mesos-experiments/scripts/common-files/haproxy-marathon-bridge install_haproxy_system localhost:8080

# Set ip of the slave. Slave or master should choice a bad interface like loopback
# and only have routable addresses to avoid issues
echo "${MASTER_ADDRESS}" | sudo tee /etc/mesos-master/ip
#echo "${MASTER_HOST_NAME}" | sudo tee /etc/mesos-slave/ip

# Register zookeeper master url for slave
echo "zk://${MASTER_ADDRESS}:2181/mesos" | sudo tee /etc/mesos/zk

# Register a human readable name for cluster
echo "Mesos1-Jessie-Cluster" | sudo tee /etc/mesos-master/cluster

# Enable Mesos support for Docker
# echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers
# echo "8mins" | sudo tee /etc/mesos-slave/executor_registration_timeout

# Add entry to /etc/hosts for slave
echo -e "${SLAVE1_ADDRESS} #{SLAVE1_HOSTNAME}\n" >> /etc/hosts
echo -e "${SLAVE2_ADDRESS} #{SLAVE2_HOSTNAME}\n" >> /etc/hosts
echo -e "${SLAVE3_ADDRESS} #{SLAVE3_HOSTNAME}\n" >> /etc/hosts

chown -R zookeeper:zookeeper /var/lib/zookeeper
chown -R zookeeper:zookeeper /etc/zookeeper

# First startup
/etc/rc.local