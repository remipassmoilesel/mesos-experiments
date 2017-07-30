# Expériences sur Mesos

Diverses expériences sur Mesos, l'outil de gestion de cluster.

## Utiliser l'environnement de développement

Sur Ubuntu:

    $ git clone https://github.com/remipassmoilesel/mesos-experiments
    $ cd jessie-vagrant

    $ sudo apt install virtualbox vagrant
    $ vagrant plugin install vagrant-hostmanager 
    $ vagrant plugin install vagrant-vbguest
    
    $ vagrant up
    $ vagrant ssh
    
Pour vérifier si le réseau fonctionne: 

    $ ping 192.168.0.40 
    $ ping 192.168.0.41 
    
Il peut être nécéssaire d'ajouter à votre fichier hosts:

    $ echo "192.168.0.40    master-jessie.mesos"  >> /etc/hosts   
    $ echo "192.168.0.41    slave-jessie.mesos"   >> /etc/hosts   
    
Deux interfaces web sont ensuite disponibles:

    http://master-jessie.mesos:5050 > Mesos master
    http://master-jessie.mesos:8080 > Marathon
    
SSH est disponible directement sur les machines:

    master: 10022
    slave:  10023