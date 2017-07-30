# Installer et ajouter un esclave Mesos

Installer Mesos, Zookeeper, et HAProxy 

    $ apt-get install -y mesos zookeeper zookeeperd haproxy haproxy-doc

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