# prometheus

## prometheus-operator


https://github.com/prometheus-operator/prometheus-operator

Prometheus Operator提供Kubernetes对Prometheus及其相关监视组件的本地部署和管理 。该项目的目的是简化和自动化针对Kubernetes集群的基于Prometheus的监视堆栈的配置。

Prometheus运算符包括但不限于以下功能：

Kubernetes自定义资源：使用Kubernetes自定义资源来部署和管理Prometheus，Alertmanager和相关组件。

简化的部署配置：从本地Kubernetes资源配置Prometheus的基础知识，例如版本，持久性，保留策略和副本。

Prometheus目标配置：基于熟悉的Kubernetes标签查询自动生成监视目标配置；无需学习Prometheus特定的配置语言。

## kube-prometheus

https://github.com/prometheus-operator/kube-prometheus

kube-prometheus提供了基于Prometheus和Prometheus Operator的完整集群监控堆栈的示例配置。提供易于操作的端到端Kubernetes集群监视服务。

kube-prometheus收集了Kubernetes清单，Grafana仪表板和Prometheus规则，以及文档和脚本。

## 下载安装

```
git clone git@github.com:prometheus-operator/kube-prometheus.git
#安装crd和operator
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
#安装Prometheus、grafana、node-exporter、blackbox-exporter、prometheus-adapter、kube-state-metrics等
kubectl create -f manifests/
```
###配置alertmanager

测试使用时，暂时修改
alertmanager-alertmanager.yaml 修改replicas为1 


## grafana ingress

```
kubectl apply -f grafana-ingress.yaml
```

http://grafana.local.io:8080/login

使用admin/admin登录后修改密码




## 卸载
```
kubectl delete --ignore-not-found=true -f manifests/ -f manifests
kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup
```

## import image
如果是k3d 拉起的集群，最好导入镜像
```
k3d image import -c alex \
quay.io/prometheus-operator/prometheus-operator:v0.45.0 quay.io/brancz/kube-rbac-proxy:v0.8.0 \
quay.io/prometheus/node-exporter:v1.1.0 quay.io/prometheus/alertmanager:v0.21.0 \
k8s.gcr.io/kube-state-metrics/kube-state-metrics:v1.9.8 quay.io/prometheus/blackbox-exporter:v0.18.0 \
directxman12/k8s-prometheus-adapter:v0.8.3 quay.io/prometheus/prometheus:v2.24.0 \
grafana/grafana:7.3.7
```

## 问题

1. 在k3d 集群中遇到svc的ip无法访问的问题 暂时没有找到根因 修改prometheus spec.clusterIP为None解决

## ref
>http://docs.kubernetes.org.cn/703.html
>https://github.com/prometheus-operator/kube-prometheus/blob/main/docs/exposing-prometheus-alertmanager-grafana-ingress.md