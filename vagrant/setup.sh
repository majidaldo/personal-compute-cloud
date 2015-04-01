#!/bin/sh

#should be run once before the first ./vagrant up


if [ ! -f ./firsttime.state ]
then
    echo 1 > ./firsttime.state
fi


if [ $(cat firsttime.state) = "1" ]
then
    #vagrant plugin installs could be here
    source ./get_envs
    #to avoid recursion...
    mv ./setup.sh ./dontrunsetup.sh
    #...when running this script from a vagrantfile
    ./vagrant box add --force --name $DOCKER_BOX $DOCKER_URL
    ./vagrant box add --force --name $REGISTRY_BOX $REGISTRY_URL
    mv ./dontrunsetup.sh ./setup.sh
    if [ $? -ne 0 ] #err on above line
    then
	exit $?
    else 
	echo 0 > ./firsttime.state
    fi
fi
