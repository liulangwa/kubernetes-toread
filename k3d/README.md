# k3d

kubernetes(containerd) in docker

## download

https://github.com/rancher/k3d

https://github.com/rancher/k3d/releases

## install kubectl

## install k3d

```
    #wget https://github.com/rancher/k3d/releases/download/v4.2.0/k3d-linux-amd64
    #mv k3d-linux-amd64 /usr/local/bin/k3d
    #k3d version
    #docker pull  docker.io/rancher/k3d-tools:v4.2.0
    #docker pull  docker.io/rancher/k3s:v1.20.2-k3s1
    #docker pull  docker.io/rancher/k3d-proxy:v4.2.0

```

## create k3s cluster

```

k3d cluster create alex
export KUBECONFIG="$(k3d kubeconfig write alex)"
kubectl config use-context k3d-alex
kubectl cluster-info

```

## show docker info

```
docker ps  --no-trunc

```

## import images

```
k3d image import -c alex nginx:1.19.1-alpine quay.io/brancz/kube-rbac-proxy:v0.8.0 quay.io/prometheus/node-exporter:v1.1.0 quay.io/prometheus/alertmanager:v0.21.0

```


## ref
>https://k3d.io/
>https://kubernetes.io/docs/tasks/tools/install-kubectl/
>https://zhuanlan.zhihu.com/p/59048502