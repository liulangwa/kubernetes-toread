# k3s

### download install shell

```
curl -sfL https://get.k3s.io -o install.sh
```
### master install
```
ARCH=amd64 INSTALL_K3S_SKIP_START=false INSTALL_K3S_SKIP_DOWNLOAD=false \
K3S_TOKEN=xxxtoken  bash ./install.sh --write-kubeconfig-mode 644

```

### agent install

K3S_URL 指定master apiserver的url

```
ARCH=amd64 INSTALL_K3S_SKIP_DOWNLOAD=false K3S_TOKEN=xxxtoken  K3S_URL="https://114.67.168.9:6443"  ./install.sh --write-kubeconfig-mode 644

```

### use other runtime driver

k3s默认containerd作为运行时，指定docker为运行时

```
ARCH=amd64 INSTALL_K3S_SKIP_DOWNLOAD=false K3S_TOKEN=xxxtoken  K3S_URL="https://114.67.168.9:6443"  ./install.sh --write-kubeconfig-mode 644 --docker
```

### uninstall

```
#To uninstall K3s from a server node, run:
/usr/local/bin/k3s-uninstall.sh

#To uninstall K3s from an agent node, run:
/usr/local/bin/k3s-agent-uninstall.sh
```



### offline install

offline-install-agent.sh和offline-install-master.sh是离线安装的一个例子，需要其他下载好`k3s`和`依赖的镜像`



### ref
>https://k3s.io/
>https://rancher.com/docs/k3s/latest/en/installation/ha/
>https://rancher.com/docs/k3s/latest/en/installation/install-options/
>https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/


