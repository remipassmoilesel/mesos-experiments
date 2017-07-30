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
    $ apt-get install openjdk-8-jre -t jessie-backports

Installer Mesos et les frameworks principaux:

    $ apt-get -y install mesos marathon chronos 

Ensuite une interface web est disponible ici:

    http://localhost:5050/
    
Tester ensuite l'installation:

    $ mesos ps
    
Si une erreur d'import apparait:

    $ pip install pip --upgrade
    $ pip install mesos.cli

## Installer Docker

Installer Docker:

    # Install Docker
    curl -fsSL get.docker.com | sh

    # Add docker group to vagrant user
    usermod -aG docker vagrant

    # Install docker compose
    apt-get install -y python-pip -t jessie-backports
    pip install docker-compose

Configurer mesos-slave pour Docker:

    $ echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers
    $ echo "8mins" | sudo tee /etc/mesos-slave/executor_registration_timeout

## Installer Zookeeper

Installer zookeeper + les scripts de démarrage:

    $ sudo apt-get install zookeeper zookeeperd
    
Vérifier l'installation:
    
    $ sudo service zookeeper status
    $ echo ruok | nc 127.0.0.1 2181
    imok    

## Installer HAProxy

Installation:

    $ sudo apt-get install haproxy haproxy-doc

## Démarrer mesos-slave et marathon

Il n'existe pas de script de démarrage par défaut. Il est possible d'ajouter ces 
commandes à /etc/rc.local:

    $ sudo service mesos-slave start
    $ sudo service marathon start
    
Dans l'interface de mesos, un nouvel agent doit apparaitre.

Une nouvelle interface web est disponible à l'adresse:

    $ http://localhost:8080/
    
/!\ Si l'hôte a un nom, marathon éxecute des requête asynchrone vers le nom d'hôte et 
l'interface affiche qu'elle est déconnectée. Dans ce cas ajouter au fichier 
 /etc/hosts du client:
 
     $ echo "192.168.2.10    master-jessie.mesos" > /etc/hosts    

