#!/bin/sh




if [ ! -f /project/files/images/docker/bootstrap/registry.tar ];
then
    mkdir -p /project/files/images/docker/bootstrap
    cd /project/docker
    docker build -t docker-registry docker-registry 
    docker save -o /project/files/images/docker/bootstrap/registry.tar \
        docker-registry
fi
 
