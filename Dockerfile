# Set the base image
FROM ethereum/client-go

# Dockerfile author / maintainer 
MAINTAINER Name <inaki.seco@opendeusto.es> 

# Expose default port
EXPOSE 30303

# Copy nedeed files
COPY /docker_image /

#RUN geth account new --datadir /node1 --password /node1/keystore/passwd
#RUN geth init genesis.json --datadir node1/ --password /node1/keystore/passwd
#RUN geth account new --datadir node1/ --
#RUN geth --mine --networkid 1 console --datadir node1/ --port 30302
