# kafka cluster
installed by helm 

### install 

```
kubectl create ns middleware
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install kafka --set replicaCount=3 bitnami/kafka -n middleware
或者使用已经部署的zookeeper
helm install kafka --set replicaCount=3 --set zookeeper.enabled=false --set externalZookeeper.servers=zookeeper  bitnami/kafka -n middleware

```

```
xx:~$ helm install kafka --set replicaCount=2 --set zookeeper.enabled=false --set externalZookeeper.servers=zookeeper  bitnami/kafka -n middleware
NAME: kafka
LAST DEPLOYED: Wed Feb 24 18:27:09 2021
NAMESPACE: middleware
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    kafka.middleware.svc.cluster.local

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    kafka-0.kafka-headless.middleware.svc.cluster.local:9092
    kafka-1.kafka-headless.middleware.svc.cluster.local:9092

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:2.7.0-debian-10-r64 --namespace middleware --command -- sleep infinity
    kubectl exec --tty -i kafka-client --namespace middleware -- bash

    PRODUCER:
        kafka-console-producer.sh \
            --broker-list kafka-0.kafka-headless.middleware.svc.cluster.local:9092,kafka-1.kafka-headless.middleware.svc.cluster.local:9092 \
            --topic test

    CONSUMER:
        kafka-console-consumer.sh \
            --bootstrap-server kafka.middleware.svc.cluster.local:9092 \
            --topic test \
            --from-beginning

```



### download chart

下载chart到本地，这步可以省略

```
helm pull bitnami/kafka

```

### list helm instance

```
helm list -n middleware
helm list --all-namespaces
```
### delete helm instance

```
helm uninstall kafka -n middleware

```


### ref
>https://github.com/bitnami/charts

>https://helm.sh/zh/docs/helm/helm_pull/

>https://artifacthub.io/packages/helm/bitnami/kafka
