#!/bin/bash

sudo apt-get update

sudo swapoff -a
#vi /etc/fstab #this command use for disable swap by comment "#"

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

sudo tee /etc/modules-load.d/containerd.conf << EOF
overlay
br_netfilter
EOF

sudo sysctl --system

sudo apt install curl gnupg2 software-properties-common apt-transport-https ca-certificates -y

#Docker installation

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install containerd.io -y

mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

#cluster setup 
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet && sudo systemctl start kubelet
sudo apt-mark hold kubelet kubeadm kubectl