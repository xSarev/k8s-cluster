#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

MASTER_IP=$1
echo $MASTER_IP
# Update the apt package index and install packages needed to use the Kubernetes repo
sudo apt-get install apt-transport-https
sudo apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl

# Add Kubernetes GPG key
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Setup Kubernetes Repo
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | \
    sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install kubelet, kubeadm and kubectl, and pin their version
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "${MASTER_IP}  cluster-endpoint.local" >> /etc/hosts

# Fix pre-flights issues
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

# Init kubernetes cluster
sudo kubeadm init --pod-network-cidr 10.244.0.0/16 --control-plane-endpoint cluster-endpoint.local

# Add kube config settings
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a Pod network to the cluster
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml