# Set the base image
FROM ethereum/client-go

# Dockerfile author / maintainer 
MAINTAINER Name <inaki.seco@opendeusto.es> 

# Expose default port
EXPOSE 30303

# Copy nedeed files
COPY /docker_image/ /
COPY /ethash/* root/.ethash/
