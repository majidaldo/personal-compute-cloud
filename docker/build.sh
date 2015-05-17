#!/bin/sh
#LOCAL

#builds and pushes into pvt registry.
#cleans up too

#exit


SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

#docker file dirs should have digits followed by -
#like 123-dockerfiledir
#order in the files is needed to take care of deps
for adfdir in $(ls -d1 */ | grep -Ei '[0-9]-')
do
    #use dir as a name. numbers
    #                  remove / from dir/   remove "number-"
    name=$(echo $adfdir | sed 's/\///' | sed 's/[0-9]*-//')
    echo building $name
    #start with it if it's already there
    docker pull          $REGISTRY_HOST/$name
    docker build                    -t  $name $adfdir
    echo loading into registry \
	                 $REGISTRY_HOST/$name
    #assuming repos in 'root' ( library/ )
    docker rmi           $REGISTRY_HOST/$name
    docker tag    $name  $REGISTRY_HOST/$name
    docker push          $REGISTRY_HOST/$name
    docker rmi           $REGISTRY_HOST/$name
    #docker rmi                          $name
done


#since i'm remounting /var/lib/docker no need to repull stuff from registry
#extra. only the 'base' images should be left
#docker rmi $(docker images -q) | :
