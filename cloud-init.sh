#!/bin/bash
# Cloud-init bootstrap for DevSecOps lab instance

# Update system and install essential packages
apt update && apt upgrade -y
apt install -y docker.io docker-compose git curl htop unzip

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add the 'ubuntu' user to the Docker group
usermod -aG docker ubuntu

# Create a DevSecOps lab workspace
mkdir -p /home/ubuntu/devsecops-lab
chown -R ubuntu:ubuntu /home/ubuntu/devsecops-lab