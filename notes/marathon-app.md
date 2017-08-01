# Gérer les applications avec marathon

Spécification du app.json disponible dans le code: https://github.com/mesosphere/marathon/blob/master/docs/docs/rest-api/public/api/v2/schema/AppDefinition.json

Exemple d'application docker simple:

    {
      "id": "bee-sample",
      "cpus": 1,
      "mem": 128,
      "disk": 0,
      "instances": 1,
      "type": "DOCKER",
      "volumes": [],
      "container": {
        "docker": {
          "image": "10.0.3.221:5000/bee-sample:1.0.0",
          "network": "BRIDGE",
          "portMappings": [
            {
              "containerPort": 8000,
              "hostPort": 0,
              "servicePort": 80,
              "protocol": "tcp",
              "labels": {}
            }
          ],
          "privileged": false,
          "parameters": [],
          "forcePullImage": false
        }
      }
    }
    
    
## Docker 

Utiliser un dépôt docker distant:
    
    "container": {
            "docker": {
              "image": "10.0.3.221:5000/bee-sample:1.0.0", // si une ip est spécifiée, le dépôt peut 
                                                           // être considéré comme insecure, l'ajouter au daemon.json

Partager le réseau de l'hôte (dont la résolution de nom):

    "docker": {
        "parameters": [
              {
                "key": "net",
                "value": "host"
              }
            ],

Ajouter des arguments de ligne de commande pour la commande run de docker. Equivalent de `docker run --net host ...`:

    "docker": {
        "parameters": [
              {
                "key": "net",
                "value": "host"
              }
            ],