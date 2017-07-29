# Installer Mesos sur Debian Jessie

## Installation de Mesos, Marathon et Chronos

Ajouter des dépôts et mettre à jour: 

    export DEBIANFRONTEND=noninteractive

    # Add the repository and update index
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
    export DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
    export CODENAME=$(lsb_release -cs)

    # Add repos
    echo "deb http://ftp.de.debian.org/debian jessie-backports main"    | tee -a /etc/apt/sources.list
    echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main"   | tee /etc/apt/sources.list.d/mesosphere.list
    apt-get -y update
    apt-get -y upgrade

Installer Java 8 à partir des backports 

    # Install java 8
    apt-get install openjdk-8-jre -t jessie-backports

Installer Mesos et les frameworks principaux:

    apt-get -y install mesos marathon chronos
    apt-get -y install zookeeper zookeeperd -t jessie-backports

## Installer Docker

Installer Docker:

    # Install Docker
    curl -fsSL get.docker.com | sh

    # Add docker group to vagrant user
    usermod -aG docker vagrant

    # Install docker compose
    apt-get install -y python-pip -t jessie-backports
    pip install docker-compose

## Installer Zookeeper

Installer zookeeper + les scripts de démarrage:

    $ sudo apt install zookeeper zookeeperd
    
Vérifier l'installation:
    
    $ sudo service zookeeper status
    $ echo ruok | nc 127.0.0.1 2181
    imok    


