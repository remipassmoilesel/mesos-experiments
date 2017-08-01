# TODO

## Général

- Créer des health checks
- Scripts Ansible pour créer un noeud slave
- Voir Apache Sparks
- Créer 3 maitres et tester zookeeper
- Ajouter un serveur Apache à l'env de dev avec service statique d'une page contenant les liens des Web UI?
- Etudier hostmode / bridgemode (network/marathon)

### Vragrant dev

- Supprimer HAProxy de l'esclave
- Arreter d'utiliser rc.local et utiliser systemd

## Possibilités intérressantes

### Aurora,

### Statefull

https://mesosphere.github.io/marathon/docs/persistent-volumes.html

### MarathonLb

"and VHost based load balancing, allowing you to specify virtual hosts for your Marathon applications."
Peut permettre de créer des domaines pour mongodb.

Voir notamment l'application Docker.

https://mesosphere.github.io/marathon/docs/service-discovery-load-balancing.html

### Marathon artifact store

Stocker des fichiers dans un magasin (ex: configuration).
Poster:

    POST /v2/artifacts/special/file/name.txt HTTP/1.1
    
Récupérer:

    GET /v2/artifacts/special/file/name.txt HTTP/1.1
    
Effacer:
    
    DELETE /v2/artifacts/special/file/name.txt HTTP/1.1


### Pod et IP-per-Pod Networking

Grouper des applications pour leur attribuer des ressources communes. Ne parait pas répondre au besoin MongoDB.
    
### IP-per-task

Permet d'attribuer une adresse IP par tâche, et de tirer meilleur parti de MesosDNS (enregistrements A)
Ne fonctionne pas avec Docker pour l'instant.

### Event bus

Permet d'être de se tenir au courant des déploiement et de leurs état sans pulling. 