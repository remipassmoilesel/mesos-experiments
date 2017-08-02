# Installer et utiliser un environnement de dev avec Mesos

## Mesos sur Jessie avec Vagrant

Sur Ubuntu:

    $ git clone https://github.com/remipassmoilesel/mesos-experiments
    $ cd jessie-vagrant

    $ sudo apt install virtualbox vagrant
    $ vagrant plugin install vagrant-hostmanager 
    $ vagrant plugin install vagrant-vbguest
    
    $ vagrant up
    
Pour se connecter aux machines localement:    
    
    $ vagrant ssh master
    $ vagrant ssh slave
    
    >> Des outils ont été ajoutés pour l'utilisateur root:azerty.    
    
Pour vérifier si le réseau fonctionne: 

    $ ping 192.168.0.40 
    $ ping 192.168.0.41 
    
Il peut être nécéssaire d'ajouter à votre fichier hosts:

    $ echo "192.168.0.40    master-jessie.mesos"  >> /etc/hosts   
    $ echo "192.168.0.41    slave-jessie.mesos"   >> /etc/hosts   

## Minimesos

Installation:

    $ curl -sSL https://minimesos.org/install | sh
    $ export PATH=$PATH:$HOME/.minimesos/bin
    $ minimesos -h
    
Créer un fichier minimesosFile et lancer l'installation:

    $ minimesos init  
    $ minimesos up
    $ minimesos destroy  

## Environnement communautaire disponible sur Github

Installer Vagrant, virtualbox et cloner le projet:

    $ sudo apt install vagrant virtualbox git
    $ git clone https://github.com/mdevilliers/vagrant-mesos-development-environment 
    
Lancer une machine virtuelle:

    $ cd vagrant-mesos-development-environment
    $ vagrant plugin install vagrant-hostmanager
    $ vagrant up
    
## DCOS / Vagrant, outil proposé par Mesosphere

Voir dépôt, doc claire.



