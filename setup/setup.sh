#!/bin/sh
cd $(dirname $0)



#calls all the different setup scripts that i have
#install ansible

#make registry and maybe /var/lib/docker
./projectfiles.sh
vagrant destroy -f
