#!/bin/bash
# Install Java 17
sudo apt install -y --no-install-recommends openjdk-17-jdk-headless
# install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add Jenkins master's public SSH key for SSH access

ssh-keygen -t rsa -b 4096 -N "" -f /home/ubuntu/.ssh/id_rsa
cd .ssh/
cat id_rsa.pub > authorized_keys
chmod 700 authorized_keys
