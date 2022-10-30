# Kubernetes Vagrant Cluster
Provision kubernetes cluster using vagrant

## Setup

## 1. Build Vagrant VMs

```sh
vagrant up
```

## 2. Ssh into vagrant vm

```sh
vagrant ssh <node-name>
```

- Notes:
    - To have a fully operational cluster you should install also a network plugin,
      choose one from here https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy 
