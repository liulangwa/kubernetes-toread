# calico




### donwload 

```
#curl https://docs.projectcalico.org/manifests/tigera-operator.yaml -O
#curl https://docs.projectcalico.org/manifests/custom-resources.yaml -O
```
### config

修改`pod`的`cidr`，这个得和k8s/k3s部署时得配置`一致` 

```
sed -i -e "s?192.168.0.0/16?10.42.0.0/16?g" custom-resources.yaml

```

### deploy

```
kubectl apply -f tigera-operator.yaml
kubectl apply -f custom-resources.yaml

```


### ref
>https://docs.projectcalico.org/getting-started/kubernetes/k3s/quickstart
>https://docs.projectcalico.org/getting-started/kubernetes/hardway/configure-ip-pools