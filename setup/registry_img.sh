#!/bin/sh


source ../common.src
drid=`$ENVCMD REGISTRYIMG_DIR` #docker registry img dir
#local or remote wont matter. resolves to same pth

if [ ! -f ${drid}/registry.tar ];
then
    mkdir -p $drid
    cd `$ENVCMD PROJECT_DIR`/docker
    docker build -t docker-registry     docker-registry 
    docker save -o ${drid}/registry.tar docker-registry
fi

