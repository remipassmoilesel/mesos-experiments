# Mesos experiments

Various experiments on Mesos, an open source cluster management tool.

## Use dev environments

On Ubuntu:

    $ git clone https://github.com/remipassmoilesel/mesos-experiments
    $ cd devenv-jessie

    $ sudo apt install virtualbox vagrant
    $ vagrant plugin install vagrant-hostmanager 
    
    $ vagrant up
    $ vagrant ssh
    
Pour vérifier si le réseau fonctionne: 

    $ ping 192.168.2.10    