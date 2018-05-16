#!/bin/bash

if [ "$2" = "restart" ]
then
    ### Removing previous ejecutions ###
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker image rm ethereum-network-node
    
    #### Creating image ###
    docker build -t ethereum-network-node ./
fi

### Running nodes ###
counter=1
while [ $counter -le $1 ]
do
    docker stop "node$counter"
    docker rm "node$counter"
    echo Running node "node$counter"
    docker run -d --name "node$counter"  ethereum-network-node --rpcaddr 0.0.0.0
    gnome-terminal --tab -e "docker exec -it 'node$counter' sh"
    #gnome-terminal --tab -e "docker exec -it 'node$counter' sh run.sh '$counter'"
    ((counter++))
done

echo DONE!
