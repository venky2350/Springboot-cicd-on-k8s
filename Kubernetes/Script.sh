#!/bin/bash

# Exit on error
set -e

echo "🔧 Updating packages and installing dependencies..."
sudo apt update -y && sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release git unzip

echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo usermod -aG docker $USER
newgrp docker

echo "🔧 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

echo "📦 Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "🚀 Starting Minikube..."
minikube start --driver=docker

echo "✅ Verifying Minikube..."
kubectl get nodes

echo "🔧 Installing Jenkins (via Docker)..."
docker network create jenkins
docker volume create jenkins_home

docker run -d --name jenkins \
  --restart=always \
  --network jenkins \
  -u root \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.kube:/root/.kube \
  jenkins/jenkins:lts

echo "✅ Jenkins is running at http://<EC2-PUBLIC-IP>:8080"
echo "🔐 Jenkins initial password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
