#!/bin/bash

# Update package list and install dependencies
sudo apt-get update -y
sudo apt-get install -y curl apt-transport-https

# Install a hypervisor (VirtualBox in this case)
echo "Installing VirtualBox..."
sudo apt-get install -y virtualbox virtualbox-ext-pack

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube
echo "Starting Minikube..."
minikube start

# Verify installation
echo "Verifying installation..."
kubectl get nodes

echo "Minikube installation and setup is complete!"

