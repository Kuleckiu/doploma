#!/bin/bash

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Add Docker repository and install Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Configure Docker daemon
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# Add Kubernetes repository and install kubeadm, kubelet, and kubectl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize Kubernetes master
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubeconfig for the stas_kuleckiu user
sudo --user=stas_kuleckiu mkdir -p /home/stas_kuleckiu/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/stas_kuleckiu/.kube/config
sudo chown stas_kuleckiu:stas_kuleckiu /home/stas_kuleckiu/.kube/config

# Apply a pod network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
