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


echo `pwd` && echo $HOSTNAME

echo "Waiting for master token"
while [ ! -f $TOKEN_FILE ] 
do
  echo -n "."
  sleep 5
done

docker swarm join --token $(cat $TOKEN_FILE)
docker node ls
