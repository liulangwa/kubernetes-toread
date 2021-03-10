#argo

## install 

下载

https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml

修改configmap workflow-controller-configmap 添加 `containerRuntimeExecutor: pns `

kubectl apply -f quick-start-minimal.yaml


## ingress 