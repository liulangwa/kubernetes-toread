# dashboard

## download

## prepare images

```

docker pull kubernetesui/dashboard:v2.2.0
docker pull kubernetesui/metrics-scraper:v1.0.6

k3d image import -c alex kubernetesui/metrics-scraper:v1.0.6  kubernetesui/dashboard:v2.2.0
```
## install 
```
wget https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
```
## 暴露dashborad

1. port-forward

```
 kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard --address 0.0.0.0 9000:443

https://x.x.x.x:9000/#/login

```
2. ingress

遇到了tls的问题 `http: TLS handshake error from 10.42.2.4:53512: remote error: tls: bad certificate` ，修改traefik的启动命令，加上了`- --serversTransport.insecureSkipVerify=true`


```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./tls.key -out ./tls.crt -subj "/CN=dashboard.cloud.local"
kubectl -n kubernetes-dashboard create secret tls k8s-dashboard-secret --key ./tls.key --cert ./tls.crt

kubectl apply -n kubernetes-dashboard -f dashboard-ingress.yaml

```
## 登录

获取token

```
kubectl -n kube-system describe $(kubectl -n kube-system get secret -n kube-system -o name | grep namespace) | grep token
```

打开 https://dashboard.cloud.local:8443/#/login 填入获取的token





## ref
>https://github.com/kubernetes/dashboard
>https://stackoverflow.com/questions/59798395/for-traefik-ingress-controller-in-k3s-disable-tls-verification
>https://github.com/k3s-io/k3s/issues/1313
>https://github.com/cloudfoundry/nats-release/issues/25
>https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/
>https://segmentfault.com/a/1190000021159956
