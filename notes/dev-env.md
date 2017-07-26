# Installer et utiliser un environnement de dev avec Mesos

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

## Créer un vagrant


