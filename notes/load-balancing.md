# Balancement de charge avec Mesos

## HAProxy

HAProxy peut être utilisé pour faire du balancement de charge. La méthode la plus simple est d'utiliser
un script qui génère une configuration à partir des tâches en éxecution.

    $ wget https://raw.githubusercontent.com/mesosphere/marathon/master/examples/haproxy-marathon-bridge

Aide:

    $ ./haproxy-marathon-bridge 

Pour installer le script et créer un cron job:

    $ ./haproxy-marathon-bridge install_haproxy_system localhost:8080
    
    >> où localhost est le domaine de marathon, 8080 le port 

La configuration générée est disponible dans:

    $ cat /etc/haproxy/haproxy.cfg 
    $ cat /etc/haproxy-marathon-bridge/marathons 

Ce script a été déprécié par Mesosphere (entreprise) au profit d'une de leurs solutions appelée
Marathon-LB. Aucune explication a première vue. Marathon-LB nécéssite l'installation de l'outil dcos-cli 
et de son écosystème. Cette solution est également basée sur HAProxy.

https://dcos.io/docs/1.9/networking/marathon-lb/

## Mesos-DNS

Mesos DNS est la solution conseillée du moment. Elle permet d'effectuer le même travail sans HAProxy.

https://github.com/mesosphere/mesos-dns/releases

Le problème est ensuite sur la gestion des ports. De plus, de nombreux 

## TODO

Finaliser une installation de marathon-lb.