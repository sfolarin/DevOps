#!/bin/bash

#############################################################
#                    Author: Shola Folarin                  #
#                    Date:   06/19/2024                     #
#                    Purpose: Docker Engine Installation    #
# ###########################################################

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
echo "Updating the Ubuntu Server"
sudo apt-get update -y

echo "Installing the certificates"
sudo apt-get install ca-certificates curl 

echo "Installing the keyrings"
sudo install -m 0755 -d /etc/apt/keyrings 

echo "Downloading dockers"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc 

echo "Activating the docker"
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

echo "Docker-Compose-Plugin-Installation"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
