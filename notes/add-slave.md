# Installer et ajouter un esclave Mesos

Installer Mesos et Zookeeper: 

    // add mesosphere repository and install java from backports
    
    # Add the mesosphere repository and update index
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
    export DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
    export CODENAME=$(lsb_release -cs)
    
    echo "deb http://ftp.de.debian.org/debian jessie-backports main contrib non-free"    | tee /etc/apt/sources.list.d/backports.list
    echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main"   | tee /etc/apt/sources.list.d/mesosphere.list
    apt-get update -y
    apt-get upgrade -y
    
    # Install java 8
    apt-get install -y openjdk-8-jre -t jessie-backports

    // install mesos and zookeeper
    
    $ apt-get install -y mesos zookeeper zookeeperd 

Installer Docker:
        
    $ curl -fsSL get.docker.com | sh
    usermod -aG docker vagrant

Installer python-pip, mesos-cli, docker-compose:

    apt-get install -y python-pip -t jessie-backports
    pip install pip --upgrade
    pip install docker-compose
    pip install mesos.cli

Installer le script de mise à jour du proxy en fonction des tâches Marathon:

    $ wget https://raw.githubusercontent.com/mesosphere/marathon/master/examples/haproxy-marathon-bridge
    $ chmod +x haproxy-marathon-bridge install_haproxy_system master-jessie.mesos:5050
    $ ./haproxy-marathon-bridge install_haproxy_system master-jessie.mesos:5050

Désactiver le mode maitre:
        
    $ echo manual | sudo tee /etc/init/mesos-master.override

Il est nécessaire de spécifier les adresses routables master/slave pour éviter qu'une mauvaise interface 
réseau soit utilisée (loopback, etc...)  
    
    $ echo 192.168.0.41 | sudo tee /etc/mesos-slave/ip

Enregistrer l'adresse zookeeper du maitre: 
    
    $ echo "zk://#{masterAddress}:2181/mesos" | sudo tee /etc/mesos/zk

Activer Docker:

    $ echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers
    $ echo "8mins" | sudo tee /etc/mesos-slave/executor_registration_timeout

S'assurer que le nouveau noeud peut résoudre le nom du maitre. En dév par exemple:

    $ echo -e "#{masterAddress} #{masterHostName}\n" >> /etc/hosts