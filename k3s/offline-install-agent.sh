#!/bin/bash


# 关掉 selinux
setenforce 0
sed -i "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux
# 关掉防火墙
systemctl stop firewalld
systemctl disable firewalld
echo -e "set ipforward"
# 设置系统运行路由转发
cat <<EOF > /etc/sysctl.d/k3s.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
# 生效配置
modprobe br_netfilter
sysctl -p /etc/sysctl.d/k3s.conf

echo -e "enable ipvs"

echo -e "cp offline images to k3s/agnent/images"
ARCH=amd64
sudo mkdir -p /var/lib/rancher/k3s/agent/images/
sudo cp ./k3s-airgap-images-$ARCH.tar /var/lib/rancher/k3s/agent/images/

echo -e "install k3s binary "

chmod +x k3s
scp k3s /usr/local/bin/


echo -e "install k3s agent"

#############注意修改此值############################
PUBLIC_IP="10.0.0.79"
#####################################################

INSTALL_K3S_SKIP_DOWNLOAD=true K3S_TOKEN=xxxToken  K3S_URL="https://${PUBLIC_IP}:6443"  ./install.sh


