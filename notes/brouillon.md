# Brouillon

## Appellations

Apache Mesos est le logiciel de base.
Mesosphere est une solution logicielle commerciale.

## Architecture

Voir le schéma sur https://www.digitalocean.com/community/tutorials/an-introduction-to-mesosphere

Description des rôles:

	Master daemon: runs on a master node and manages slave daemons
	Slave daemon: runs on a master node and runs tasks that belong to frameworks
	Framework: also known as a Mesos application, is composed of a scheduler, which registers with the master to receive resource offers, and one or more executors, which launches tasks on slaves. Examples of Mesos frameworks include Marathon, Chronos, and Hadoop
	Offer: a list of a slave node's available CPU and memory resources. All slave nodes send offers to the master, and the master provides offers to registered frameworks
	Task: a unit of work that is scheduled by a framework, and is executed on a slave node. A task can be anything from a bash command or script, to an SQL query, to a Hadoop job
	Apache ZooKeeper: software that is used to coordinate the master nodes

Pour une meilleure disponibilité, 3 maitres sont recommandés au minimum, 5 étant la valeur optimales.

## Marathon
Framework conçu pour lancer des opérations longues.
Gère l'initialisation, la vérification de santé, mise à l'échelle, découverte de service, ...
Possède une interface web et créé des statistiques.

## Chronos
Framework de planification de tâches. Planifie des 'jobs' qui sont des groupes de 'tâches'.
Créé des statistiques également.

## HapProxy
Répartiteur de charge

## Premières impression

### Plus
- abstraction du cluster pour ne former qu'une machine

