#!/bin/bash

function createImage() {
    echo Creating ethereum-network-node image
    docker build -t ethereum-network-node ./
}

function closeDockers() {
    if [[ -n $( docker ps -a -q -f ancestor=ethereum-network-node ) ]]; then
        echo Removing all the ethereum-network-node containers
        docker stop $( docker ps -q -f ancestor=ethereum-network-node )
        docker rm $( docker ps -a -q -f ancestor=ethereum-network-node )
    else
        echo There are no containers to remove
    fi
}

function removeImage() {
    echo Removing ethereum-network-node image
    docker image rm ethereum-network-node
}





case $1 in
    start)
        echo starting 
        #### Creating image ###
        if [[ -n $( docker images -q ethereum-network-node ) ]]; then
            echo "Image already exists, to create it again use 'sudo ./build restart'"
        else
            createImage
        fi
        ;;

    restart) 
        if [[ -n $( docker images -q ethereum-network-node ) ]]; then
            echo restarting
            ### Removing previous ejecutions ###
            closeDockers 
            removeImage
            #### Creating image ###
            createImage
        else
            echo "The image does not exist yet, create it with 'sudo ./build start'"
        fi
        ;;

    close)
        closeDockers
        ;;

    remove)
        if [[ -n $( docker ps -a -q -f ancestor=ethereum-network-node ) ]]; then
            echo "To remove the image first you need to close the containers by 'sudo ./build.sh close'"
        else
            removeImage
        fi
        ;;

    *)  
        echo Creating "$1" nodes
        ### Running nodes ###
        counter=1
        while [ $counter -le $1 ]
        do
            if [[ -n $( docker ps -q -f name="node$counter" ) ]]; then
            echo "The node$counter already exists, let's remove it"
                docker stop "node$counter"
                docker rm "node$counter"
            fi
            echo Creating "node$counter"
            docker run -d --name "node$counter"  ethereum-network-node --rpcaddr 0.0.0.0
            echo Running node "node$counter"
            gnome-terminal --tab -e "docker exec -it 'node$counter' sh"
            #gnome-terminal --tab -e "docker exec -it 'node$counter' sh run.sh 'node$counter'"
            ((counter++))
        done
        ;;
esac