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
    
```
## prepare images

```
    docker pull  docker.io/rancher/k3d-tools:v4.2.0
    docker pull  docker.io/rancher/k3s:v1.20.2-k3s1
    docker pull  docker.io/rancher/k3d-proxy:v4.2.0
    docker pull  docker.io/rancher/library-traefik:1.7.19
    docker pull  rancher/local-path-provisioner:v0.0.14
    docker pull  rancher/coredns-coredns:1.8.0
    docker pull  rancher/metrics-server:v0.3.6
    docker pull  rancher/klipper-helm:v0.4.3
    docker pull  rancher/klipper-lb:v0.1.2

```

## create k3s cluster

```

k3d cluster create alex
export KUBECONFIG="$(k3d kubeconfig write alex)"
kubectl config use-context k3d-alex
kubectl cluster-info

```
## import images

```
k3d image import -c alex rancher/local-path-provisioner:v0.0.14 rancher/coredns-coredns:1.8.0 rancher/metrics-server:v0.3.6 rancher/klipper-helm:v0.4.3 rancher/klipper-lb:v0.1.2
```

## show docker info

```
docker ps  --no-trunc
```

## info

`--k3s-server-arg "--no-deploy=traefik" ` 参数可以不预装ingress-controller，这样就可以按自己的需求去装ingress-controller了。cluster/traefik-ingress-controller 就提供了一个例子。

## ref
>https://k3d.io/
>https://kubernetes.io/docs/tasks/tools/install-kubectl/
>https://zhuanlan.zhihu.com/p/59048502