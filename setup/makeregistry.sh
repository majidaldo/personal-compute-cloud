#!/bin/sh




if [ ! -f /tsad-proj/tsad-bigfiles/images/docker/bootstrap/registry.tar ];
then
    mkdir -p /tsad-proj/tsad-bigfiles/images/docker/bootstrap
    cd /tsad-proj/tsad-sys/docker
    docker build -t docker-registry docker-registry 
    docker save -o /tsad-proj/tsad-bigfiles/images/docker/bootstrap/registry.tar \
        docker-registry
fi
 