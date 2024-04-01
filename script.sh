#!/bin/bash

# Arguments
export IMAGE_TITLE=$1
export DOCKER_USERNAME=$2
export DOCKER_PASSWORD=$3

# Installing
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
docker-compose -f site-compose.yaml up --detach
