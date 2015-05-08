#!/bin/sh

#should be run once before the first ./vagrant up


if [ ! -f ./firsttime.state ]
then
    echo 1 > ./firsttime.state
fi


if [ $(cat firsttime.state) = "1" ]
then
    #vagrant plugin installs could be here
    vagrant plugin install vagrant-winnfsd
    source ./get_envs && \
    #to avoid recursion...
    mv ./setup.sh ./renameto_setup.sh && \
    #...when running this script from a vagrantfile
    mv ./renameto_setup.sh ./setup.sh
    if [ $? -ne 0 ] #err on above line
    then
	exit $?
    else 
	echo 0 > ./firsttime.state
    fi
fi
