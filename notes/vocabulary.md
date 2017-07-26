# Vocabulaire

Offre de ressource: les agents/esclaves offrent leurs ressources aux maitres

Apache Mesos: base logicielle

Mesosphere: solution logicielle commerciale basée sur Apache Mesos 

Master daemon: runs on a master node and manages slave daemons

Slave daemon: runs on a slave node and runs tasks that belong to frameworks

Framework: also known as a Mesos application, is composed of a scheduler, which registers with the master to receive resource offers, and one or more executors, which launches tasks on slaves. Examples of Mesos frameworks include Marathon, Chronos, and Hadoop

Offer: a list of a slave node's available CPU and memory resources. All slave nodes send offers to the master, and the master provides offers to registered frameworks

Task: a unit of work that is scheduled by a framework, and is executed on a slave node. A task can be anything from a bash command or script, to an SQL query, to a Hadoop job

Apache ZooKeeper: software that is used to coordinate the master nodes

