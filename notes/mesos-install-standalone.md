# Installer Mesos sur Debian Jessie

Cette note explique l'installation de Mesos master et slave sur une même machine, pour expérimentation.

Voir aussi le Vagrantfile de jessie-vagrant/

Au moment de l'écriture de cette note, les paquets sur le dépôt mesosphere ne sont disponible que pour Debian Jessie 
(pour ce qui est de Debian, voir Ubuntu et autres) 

## Installation de Mesos Master, Marathon et Chronos

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
    
Il est nécessaire de spécifier les adresses routables master/slave pour éviter qu'une mauvaise interface 
réseau soit utilisée (loopback, etc...)  
    
    $ echo 192.168.0.40 | sudo tee /etc/mesos-master/ip
    
Enregistrer les adresses des maitres (un seul ici):
      
    $ echo "zk://192.168.0.40:2181/mesos" | sudo tee /etc/mesos/zk
    
Il est possible d'enregister un nom pour le cluster:

    echo "Jessie-Cluster" | sudo tee /etc/mesos-master/cluster

Si nécéssaire enregistrer les adresses et noms des machines dans l'hôte:
  
    $ echo -e "192.168.0.41 slave-jessie.mesos\n" >> /etc/hosts

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

Configurer mesos-slave pour Docker, en déclarant le service et en fixant un timeout suffisant pour
tirer des images distantes:

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
    
Installer le script de mise à jour du proxy en fonction des tâches Marathon:

    $ wget https://raw.githubusercontent.com/mesosphere/marathon/master/examples/haproxy-marathon-bridge
    $ chmod +x haproxy-marathon-bridge install_haproxy_system master-jessie.mesos:5050
    $ ./haproxy-marathon-bridge install_haproxy_system master-jessie.mesos:5050

## Configurer mesos-slave

Il est nécessaire de spécifier les adresses routables master/slave pour éviter qu'une mauvaise interface 
réseau soit utilisée (loopback, etc...)  
    
    $ echo 192.168.0.41 | sudo tee /etc/mesos-slave/ip

Si nécéssaire il faut enregistrer les adresses des maitres pour l'esclave:
  
    $ echo "zk://192.168.0.40:2181/mesos" | sudo tee /etc/mesos/zk

Si nécéssaire enregistrer les adresses et noms des machines dans l'hôte:
  
    $ echo -e "192.168.0.40 master-jessie.mesos\n" >> /etc/hosts


## Démarrage des services

Il n'existe pas de script de démarrage par défaut. Il est possible d'ajouter ces 
commandes à /etc/rc.local ou de faire un script System V:

    $ sudo service mesos-master start
    $ sudo service mesos-slave start
    $ sudo service marathon start
       
Dans l'interface de mesos, un nouvel agent doit apparaitre.

Une nouvelle interface web est disponible à l'adresse:

    $ http://localhost:8080/
    
/!\ Si l'hôte a un nom, marathon éxecute des requête asynchrone vers le nom d'hôte et 
l'interface affiche qu'elle est déconnectée. Dans ce cas ajouter au fichier 
 /etc/hosts du client:
 
     $ echo "192.168.2.10    master-jessie.mesos" > /etc/hosts    

Ensuite une interface web est disponible ici:

    http://localhost:5050/
    