#!/usr/bin/env bash

# Activate debug
set -x

. ./config.sh

export SLAVE_ADDRESS=$1
export SLAVE_HOSTNAME=$2

echo "Setting up slave with address:             ${SLAVE_ADDRESS}"
echo "Setting up slave with host name:           ${SLAVE_HOSTNAME}"
echo "Setting up slave with master address:      ${MASTER_ADDRESS}"
echo "Setting up slave with master hostname:     ${MASTER_HOST_NAME}"

export DEBIANFRONTEND=noninteractive

# Add the mesosphere repository and update index
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
export DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
export CODENAME=$(lsb_release -cs)

echo "deb http://ftp.de.debian.org/debian jessie-backports main"    | tee /etc/apt/sources.list.d/backports.list
echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main"   | tee /etc/apt/sources.list.d/mesosphere.list
apt-get update -y
apt-get upgrade -y

# Install java 8
apt-get install -y openjdk-8-jre -t jessie-backports

# Fix locale for french (WIP)
echo -e 'LANG="fr_FR.UTF-8"\nLANGUAGE="fr_FR:fr"\nLC_ALL="fr_FR"\nLC_TYPE="fr_FR.UTF-8"\n' > /etc/default/locale
echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
dpkg-reconfigure -f noninteractive locales

# Add various helpers
apt-get install -y vim byobu curl wget openssh-server ranger zsh git sed htop

# Add oh my zsh for root
cd /root && git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
cp /vagrant/common-files/zshrc /root/.zshrc
chsh -s /bin/zsh

# change root password
echo root:azerty | chpasswd

##
## INSTALL MESOS
##

# Install Mesos and frameworks
apt-get install -y mesos haproxy haproxy-doc zookeeper zookeeperd

# Install Docker
curl -fsSL get.docker.com | sh

# Add docker group to vagrant user
usermod -aG docker vagrant

# install python pip and update it
apt-get install -y python-pip -t jessie-backports
pip install pip --upgrade

# install mesos cli and docker compose
pip install docker-compose
pip install mesos.cli

# Add startup script (TODO: use System V)
cp /vagrant/slave-files/rc.local /etc/rc.local
chmod +x /etc/rc.local

# Enable haproxy / marathon bridge for load balancing
/vagrant/common-files/haproxy-marathon-bridge install_haproxy_system $MASTER_HOSTNAME:8080

# Disable master mode
echo manual | sudo tee /etc/init/mesos-master.override

# Set ip of the slave. Slave or master should choice a bad interface like loopback
# and only have routable addresses to avoid issues
echo "${SLAVE_ADDRESS}" | sudo tee /etc/mesos-slave/ip

# Register zookeeper master url for slave
echo "zk://${MASTER_ADDRESS}:2181/mesos" | sudo tee /etc/mesos/zk

# Enable Mesos support for Docker
echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers
echo "8mins" | sudo tee /etc/mesos-slave/executor_registration_timeout

# Add entry to /etc/hosts for master
echo -e "${MASTER_ADDRESS} ${MASTER_HOST_NAME}\n" >> /etc/hosts

# First startup
/etc/rc.local