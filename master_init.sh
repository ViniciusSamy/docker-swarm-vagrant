#!/bin/bash

IP_ADDR=$1
TOKEN_FILE=$2

echo $IP_ADDR
echo $TOKEN_FILE

sudo yum update
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
docker swarm init --advertise-addr $IP_ADDR | grep "docker swarm join " | awk -F' ' '{print $5 " " $6}' > $TOKEN_FILE
docker service create --replicas 5 --name vagrant-service httpd
docker service ps vagrant-service
docker node ls

#docker swarm join --token SWMTKN-1-0k6n003tkxk4fave2hdyv1fe543mv1cqc02c2hid4rs62swkas-eb6891uij965m5qvm9rr33wbj 192.168.57.3:2377

