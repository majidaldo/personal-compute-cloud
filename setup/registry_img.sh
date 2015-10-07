#!/bin/sh
set -e

source ../common.src
drid=`$ENVCMD REGISTRYIMG_DIR` #docker registry img dir
#local or remote wont matter. resolves to same pth

if [ ! -f ${drid}/registry.tar ];
then
    mkdir -p $drid
    cd `$ENVCMD PROJECT_DIR`/docker
    docker pull                         distribution/registry
    docker save -o ${drid}/registry.tar distribution/registry
fi

