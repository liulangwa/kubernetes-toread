#!/bin/bash

export K3S_CLUSTER_NAME="alex"

k3d cluster delete ${K3S_CLUSTER_NAME}