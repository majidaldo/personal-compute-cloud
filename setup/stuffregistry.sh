#!/bin/sh
source ../common.src


regdatadir=`$ENVCMD REGISTRYDATA_DIR` 
regimgdir=`$ENVCMD REGISTRYIMG_DIR`


docker load --input ${regimgdir}/registry.tar
mkdir -p $regdatadir
docker run \
        --name registry \
        -d \
        -v ${regdatadir}:/var/lib/registry \
        -p 5000:5000 \
        distribution/registry


export REGISTRY_HOST=localhost:5000
cd `$ENVCMD PROJECT_DIR`/docker
./build.sh


docker stop registry
docker rm registry

