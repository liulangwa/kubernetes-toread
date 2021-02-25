#!/bin/bash


export K3S_CLUSTER_NAME="alex"
export K3S_WORKER_NUMBER=2
export K3S_EXTERNAL_IP=`ip -4 addr show eth0 | grep inet | awk '{print $2}' | cut -d'/' -f1`


echo "create k3d cluster ......"

k3d cluster create ${K3S_CLUSTER_NAME} --servers 1 --agents ${K3S_WORKER_NUMBER} \
-p "30000-30007:30000-30007@server[0]" -p "8080:80@loadbalancer" \
--k3s-server-arg --tls-san=${K3S_EXTERNAL_IP}

echo "export kubeconfig ......"

export KUBECONFIG="$(k3d kubeconfig write ${K3S_CLUSTER_NAME})"

echo "the end......"