# Installer un environnement de dev avec Mesos

## Environnement communautaire disponible sur Github

Installer Vagrant, virtualbox et cloner le projet:

    $ sudo apt install vagrant virtualbox git
    $ git clone https://github.com/mdevilliers/vagrant-mesos-development-environment 
    
Lancer une machine virtuelle:

    $ cd vagrant-mesos-development-environment
    $ vagrant plugin install vagrant-hostmanager
    $ vagrant up
    
## DCOS / Vagrant, outil proposé par Mesosphere

