# Configuration

## Zookeeper

Zookeeper permet de gérer un groupe de serveurs maitres. Dans le cas d'une panne d'un maitre,
un autre maitre est élu et prend sa place. 

Trois serveurs sont requis au minimum, 5 et plus sont conseillés toujours en nombre impair. 

La configuration se trouve dans:

    $ sudo vim /etc/zookeeper/conf/zoo.cfg
    
Spécifier les serveurs:

    server.1=mesos-master-1.example.com:2888:3888
    server.2=mesos-master-2.example.com:2888:3888
    server.3=mesos-master-3.example.com:2888:3888     
   
Premier port utilisé pour se connecter au leader, deuxième pour l'élection du leader.

## Configurer Mesos 

Mesos peut être configurer par variables d'environnement, par argument ou par fichier.

La configuration Mesos utilise ces dossier:

    /etc/mesos          -> configure maitre et esclave
    /etc/mesos/master
    /etc/mesos/slave
       
Adresses zookeeper:

    $ vim /etc/mesos/zk
    
    zk://mesos-master-1.example.com:2181,mesos-master-2.example.com:2181,mesos-master-3.example.com:2181/mesos

Nombre de maitres nécéssaires à une élection:

    $ vim /etc/mesos-master/quorum
    
    1
                                      
Pour calculer le quorum (la valeur de la majorité nécessaire pour élire un maitre): 

    Nombre de serveurs: 2 × N – 1 
    Quorum: N 
    Nombre de fautes tolérés: N – 1
    
## Configurer HAProxy

    $ vim /etc/haproxy/haproxy.cfg
    
    
    
    
    