#!/bin/bash

### Parameters ###
nodename1=$1
nodename2=$2

### Removing previous ejecutions ###
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker stop "$1" && docker rm "$1"
docker image rm ethereum-network-node

### Creating and running new image ###     ----Edita el Dockerfile para que el coja la carpeta node adecuada (pendiente de automatizar)
docker build -t ethereum-network-node .
docker run -d ethereum-network-node --rpcaddr 0.0.0.0 --name "$1" 
docker run -d ethereum-network-node --rpcaddr 0.0.0.0 --name "$2" 
docker exec -it "$1" sh
