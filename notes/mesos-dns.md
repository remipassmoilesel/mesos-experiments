# Installer et utiliser Mesos DNS

Installation:

    $ wget https://github.com/mesosphere/mesos-dns/releases/download/v0.6.0/mesos-dns-v0.6.0-linux-amd64
    $ chmod +x mesos-dns-v0.6.0-linux-amd64
    $ mv mesos-dns-v0.6.0-linux-amd64
    $ cp mesos-dns-v0.6.0-linux-amd64 /usr/local/bin/mesos-dns 
    
Lancer avec Marathon:

    {
        "cmd": "sudo  /usr/local/bin/mesos-dns -config=/root/mesos-dns-config.json",
        "cpus": 1.0,
        "mem": 1024,
        "id": "mesos-dns",
        "instances": 1,
        "constraints": [["hostname", "CLUSTER", "10.181.64.13"]]
    }
    
Attention: la config doit se trouver sur la même machine que mesos-dns.
    
Trouver le hostname à utiliser dans la constrainte:

    $ curl http://mesos1-master1.mesos:5050/master/state.json | jq '.' | less
    
Créer une configuration Mesos-DNS:

    $ vim /root/mesos-dns-config.json    

    {
      "zk": "zk://host1:port1,host2:port2/mesos/",                                      // adresses zookeeper pour déterminer le master
      "masters": ["10.101.160.15:5050", "10.101.160.16:5050", "10.101.160.17:5050"],    // liste de master  
      "refreshSeconds": 60,                                                             // temps de rafraichissement des domaines à partir des master
      "ttl": 60,                                                                        // durée de vie en cache de l'enregistrement dns
      "domain": "mesos",                                    
      "port": 53,               
      "resolvers": ["169.254.169.254"],                                                 // resolvers pour autres domaines
      "timeout": 5, 
      "httpon": true,
      "dnson": true,
      "httpport": 8123,
      "externalon": true,
      "listener": "10.101.160.16",                                                      // adresse d'écoute
      "SOAMname": "ns1.mesos",
      "SOARname": "root.ns1.mesos",
      "SOARefresh": 60,
      "SOARetry":   600,
      "SOAExpire":  86400,
      "SOAMinttl": 60,
      "IPSources": ["netinfo", "mesos", "host"]
    }

Lancer mesos-dns:

    $ sudo  /usr/local/mesos-dns/mesos-dns -config=/usr/local/mesos-dns/config.json
    
Pour afficher des logs:

    $ sudo mesos-dns -v=1
    $ sudo mesos-dns -v=2   # plus verbeux
    
Si un ping renvoi une adresse interne Docker, modifier la config:

    "IPSources": ["host", "netinfo", "mesos"]

Exemple de config:

    {
      "zk": "zk://10.0.2.25:2181/mesos",
      "masters": ["10.0.2.25:5050"],
      "refreshSeconds": 10,
      "ttl": 60,
      "domain": "mesosv",
      "port": 53,
      "resolvers": ["80.67.169.12", "80.67.169.40", "8.8.8.8", "8.8.4.4"],
      "timeout": 5, 
      "httpon": true,
      "dnson": true,
      "httpport": 8123,
      "externalon": true,
      "listener": "10.0.2.25",
      "SOAMname": "ns1.mesosv",
      "SOARname": "root.ns1.mesosv",
      "SOARefresh": 60,
      "SOARetry":   600,
      "SOAExpire":  86400,
      "SOAMinttl": 60,
      "IPSources": ["host", "netinfo", "mesos"]
    }

Ajouter le résolveur DNS aux esclaves:

    $ vim /etc/resolv.conf 
    
    nameserver 10.0.2.25    # adresse de mesos-dns


Utiliser systemd pour gérer le service:

    $ vim /lib/systemd/system/mesos-dns.service
    
    [Unit]
    Description=Mesos DNS
    After=network.target
    Wants=network.target
    
    [Service]
    ExecStart=/usr/local/bin/mesos-dns -v=1 -config=/root/mesos-dns-config.json
    ExecReload=/bin/kill -HUP $MAINPID
    KillMode=process
    Restart=on-failure
    
    [Install]
    WantedBy=multi-user.target
    
    $ systemctl daemon-reload
    $ systemctl enable mesos-dns
    $ systemctl start mesos-dns
    
    
Pings:

    $ ping leader.mesosv
    $ ping task.marathon.mesosv