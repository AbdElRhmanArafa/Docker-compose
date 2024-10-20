#!/bin/bash
# Install Java 17
sudo apt install fontconfig openjdk-17-jre

# install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add Jenkins master's public SSH key for SSH access
mkdir -p /home/ubuntu/.ssh
echo "${aws_instance.jenkins_master.public_ip}:/var/lib/jenkins/.ssh/id_rsa.pub" >> /home/ubuntu/.ssh/authorized_keys
chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys