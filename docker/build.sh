#!/bin/sh
#LOCAL

#builds and pushes into pvt registry.
#cleans up too

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

for adfdir in $(ls -d1 */)
do
    #use dir as a name. remove slashes
    name=$(echo $adfdir | sed 's/\///')
    echo building $name
    #start with it if it's already there
    docker pull          $REGISTRY_HOST/$name
    docker build                    -t  $name $adfdir
    echo loading into registry \
	                 $REGISTRY_HOST/$name
    #assuming repos in 'root' ( library/ )
    #overwrite if it's already there
    docker tag -f $name  $REGISTRY_HOST/$name
    docker push          $REGISTRY_HOST/$name
    docker rmi           $REGISTRY_HOST/$name
    docker rmi                          $name
done

#extra. only the 'base' images should be left
docker rmi $(docker images -q)
