# minio

MinIO 是一个基于Apache License v2.0开源协议的对象存储服务。它兼容亚马逊S3云存储服务接口，非常适合于存储大容量非结构化的数据，例如图片、视频、日志文件、备份数据和容器/虚拟机镜像等，而一个对象文件可以是任意大小，从几kb到最大5T不等。

MinIO是一个非常轻量的服务,可以很简单的和其他应用的结合，类似 NodeJS, Redis 或者 MySQL。


## start with docker

```
docker run -it --rm -p 9000:9000 \
  -e "MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" \
  -e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
  minio/minio server /data

```
## deploy in k3s/k8s

helm 的方式官方已经放弃维护 现在使用operator的方式部署mimio,安装一个kubectl插件

`kubectl krew install minio`

```
$kubectl krew install minio

---
Updated the local copy of plugin index.
Installing plugin: minio
Installed plugin: minio
\
 | Use this plugin:
 |      kubectl minio
 | Documentation:
 |      https://github.com/minio/operator/tree/master/kubectl-minio
 | Caveats:
 | \
 |  | * For resources that are not in default namespace, currently you must
 |  |   specify -n/--namespace explicitly (the current namespace setting is not
 |  |   yet used).
 | /
/
WARNING: You installed plugin "minio" from the krew-index plugin repository.
   These plugins are not audited for security by the Krew maintainers.
   Run them at your own risk.

```

通过插件命令安装operator
`kubectl minio init`

```
kubectl minio init

---
MinIO Operator Namespace minio-operator: created
CustomResourceDefinition tenants.minio.min.io: created
ClusterRole minio-operator-role: created
ServiceAccount minio-operator: created
ClusterRoleBinding minio-operator-binding: created
MinIO Operator Service operator: created
MinIO Operator Deployment minio-operator: created
MinIO Console Deployment: created
-----------------

To open Operator UI, start a port forward using this command:

kubectl minio proxy

```

部署租户级 minio

```
#查看下默认的storageclasses
$kubectl get storageclasses.storage.k8s.io
---
NAME                               PROVISIONER                                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)               rancher.io/local-path                          Delete          WaitForFirstConsumer   false                  89d

$kubectl create ns minio-tenant
#指定租户名 命名空间 storageclasses 存储容量
$kubectl minio tenant create minio-tenant \
    --servers 1                          \
    --volumes 4                          \
    --capacity 1Ti                       \
    --namespace minio-tenant             \
    --storage-class local-path

```
创建信息中有ak,sk 注意保存

```
Tenant 'minio-tenant' created in 'minio-tenant' Namespace

  Username: admin
  Password: aa8f9f87-3e20-4703-b013-36749addd0a6
  Note: Copy the credentials to a secure location. MinIO will not display these again.

+-------------+----------------------+--------------+--------------+--------------+
| APPLICATION | SERVICE NAME         | NAMESPACE    | SERVICE TYPE | SERVICE PORT |
+-------------+----------------------+--------------+--------------+--------------+
| MinIO       | minio                | minio-tenant | ClusterIP    | 443          |
| Console     | minio-tenant-console | minio-tenant | ClusterIP    | 9443         |
+-------------+----------------------+--------------+--------------+--------------+
```


删除minio租户

```
kubectl minio tenant delete minio-tenant --namespace minio-tenant 
```


### 访问租户s3接口

```
kubectl port-forward -n minio-tenant service/minio-tenant-hl --address 0.0.0.0 9000:9000
```
https://localhost:9000/minio/login 登录 输入创建时候的用户名和密码

### 访问租户console

```
kubectl port-forward -n minio-tenant service/minio-tenant-console --address 0.0.0.0 9443:9443
```
https://localhost:9443/login 登录 输入创建时候的用户名和密码

### 说明

minio默认使用的是k8s/k3s的ca证书，这个证书可能是私签证书，系统不认需要在客户端执行下面操作

```
sudo cp agent/server-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

## ref
>https://docs.min.io/docs/minio-erasure-code-quickstart-guide.html
>https://github.com/minio/minio-go
>https://operator.min.io/#minio-console
