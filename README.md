# Mesos experiments

Various experiments on Mesos, an open source cluster management tool.

## Use dev environments

On Ubuntu:

    $ git clone https://github.com/remipassmoilesel/mesos-experiments
    $ cd devenv-jessie

    $ sudo apt install virtualbox vagrant
    $ vagrant plugin install vagrant-hostmanager 
    $ vagrant plugin install vagrant-vbguest
    
    $ vagrant up
    $ vagrant ssh
    
Pour vérifier si le réseau fonctionne: 

    $ ping 192.168.2.10 
    
Il peut être nécéssaire d'ajouter à votre fichier hosts:

    $ echo "192.168.2.10    master-jessie.mesos" > /etc/hosts   
    
Deux interfaces web sont ensuite disponibles:

    http://master-jessie.mesos:5050 > Mesos master
    http://master-jessie.mesos:8080 > Marathon
    
SSH est disponible sur le port 10022.