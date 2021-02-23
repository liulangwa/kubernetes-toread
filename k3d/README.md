# k3d

kubernetes(containerd) in docker

### download

https://github.com/rancher/k3d

https://github.com/rancher/k3d/releases

### install 
```
    #wget https://github.com/rancher/k3d/releases/download/v4.2.0/k3d-linux-amd64
    #mv k3d-linux-amd64 /usr/local/bin/k3d
    #k3d version
```

### create k3s cluster

```

k3d cluster create alex

kubectl config use-context k3d-alex
kubectl cluster-info

```

### show docker info

```
docker ps  --no-trunc

```

### import images

```
k3d image import -c alex nginx:1.19.1-alpine

```


### ref
>https://k3d.io/
