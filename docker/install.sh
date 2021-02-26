#! /bin/bash


# 关掉 selinux
setenforce 0
sed -i "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux
# 关掉防火墙
systemctl stop firewalld
systemctl disable firewalld
# 设置系统运行路由转发
cat <<EOF > /etc/sysctl.d/netxx.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
# 生效配置
modprobe br_netfilter
sysctl -p /etc/sysctl.d/netxx.conf
# Swap分区关闭
swapoff -a
sed -ie 's/.*swap.*/#&/' /etc/fstab

echo "install docker repo......"

yum install -y lrzsz unzip epel-release

echo "remove old docker ......"

yum remove docker-ce docker-ce-cli containerd.io -y
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine -y





sudo yum install -y yum-utils bash-completion \
  device-mapper-persistent-data epel-release \
  lvm2


sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


echo "install docker ......"

sudo yum install -y docker-ce


echo "start docker ......"

sudo systemctl start docker
sudo systemctl enable docker

docker info


 


