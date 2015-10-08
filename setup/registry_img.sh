#!/bin/sh
set -e

cd $(dirname $0)
source ../common.src

drid=`$ENVCMD REGISTRYIMG_DIR` #docker registry img dir
#local or remote wont matter. resolves to same pth

if [ ! -f ${drid}/registry.tar ];
then
    mkdir -p $drid
    cd `$ENVCMD PROJECT_DIR`/docker
    docker pull                              distribution/registry
    docker save -o      ${drid}/registry.tar distribution/registry
else #update it
    docker load --input ${drid}/registry.tar | : #ignr if crptd
    docker pull                              distribution/registry
    rm                  ${drid}/registry.tar
    docker save -o      ${drid}/registry.tar distribution/registry
fi

