#!/bin/sh
source ../common.src


regdatadir=`$ENVCMD REGISTRYDATA_DIR` 
regimgdir=`$ENVCMD REGISTRYIMG_DIR`


docker load --input ${regimgdir}/registry.tar
mkdir -p $regdatadir
docker run \
        --name registry \
        -d \
        -v ${regdatadir}:/registry \
        -e STORAGE_PATH=/registry \
        -e SETTINGS_FLAVOR=dev \
        -e GUNICORN_OPTS=[--preload] \
        -p 5000:5000 \
        docker-registry


export REGISTRY_HOST=localhost:5000
cd `$ENVCMD PROJECT_DIR`/docker
./build.sh


docker stop registry
docker rm registry

