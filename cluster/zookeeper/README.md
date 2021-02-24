# zookeeper cluster
installed by helm 

### install 

```
kubectl create ns middleware
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install zookeeper bitnami/zookeeper -n middleware
```

```
# helm install zookeeper bitnami/zookeeper -n middleware

NAME: zookeeper
LAST DEPLOYED: Wed Feb 24 09:42:07 2021
NAMESPACE: middleware
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

ZooKeeper can be accessed via port 2181 on the following DNS name from within your cluster:

    zookeeper.middleware.svc.cluster.local

To connect to your ZooKeeper server run the following commands:

    export POD_NAME=$(kubectl get pods --namespace middleware -l "app.kubernetes.io/name=zookeeper,app.kubernetes.io/instance=zookeeper,app.kubernetes.io/component=zookeeper" -o jsonpath="{.items[0].metadata.name}")
    kubectl exec -it $POD_NAME --namespace middleware -- zkCli.sh 

To connect to your ZooKeeper server from outside the cluster execute the following commands:

    kubectl port-forward --namespace middleware svc/zookeeper 2181:2181 &
    zkCli.sh 127.0.0.1:2181
```

### download chart

下载chart到本地，这步可以省略

```
helm pull bitnami/zookeeper

```
### list helm instance

```
helm list -n middleware
helm list --all-namespaces
```
### delete helm instance

```
helm uninstall zookeeper -n middleware

```

### ref
>https://github.com/bitnami/charts

>https://helm.sh/zh/docs/helm/helm_pull/

>https://artifacthub.io/packages/helm/bitnami/zookeeper