# ingress-controller

如果没有像k3d/k3s一样预置ingress-controller ，需要安装一个controller 定义的ingress才能生效。
如果在k3s中想安装其他的ingress-controller 部署k3s时候需要通过安装选项禁用自带的traefix
## download

```
docker pull traefik:2.2.8
```

## install 
```
helm repo add traefik https://containous.github.io/traefik-helm-chart

helm repo list

helm install traefik traefik/traefik -n kube-system

```
## download chart

```
helm pull  traefik/traefik

```


## traefik dashborad

```
kubectl port-forward -n kube-system $(kubectl get pods -n kube-system --selector "app.kubernetes.io/name=traefik" --output=name) --address 0.0.0.0 9000:9000

```

然后在浏览器中访问 http://localhost:9000/dashboard/，正常可以访问到 traefik 的 dashboard 页面。

## ingress 测试

```
kubectl create deploy nx --image nginx
kubectl expose deploy nx --port 80 --target-port=80 --name=nx-svc

```

定义一个 Ingress 规则来使用我们新的 Traefik

```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: nx
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: web,websecure
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: nx-svc
          servicePort: 80
    host: nx.cloud.local

```

访问 http://nx.cloud.local:8080/ 会看到如下界面内容

```
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.

```


## ref
>https://cloud.tencent.com/developer/article/1739632
>https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/
>https://artifacthub.io/packages/helm/traefik/traefik
