#!/bin/bash
cd $(dirname $0) #clever! cd into this script dir from where ever
source ../../common.src #.. then find my common stuff
#should be the header of all my scripts. todo.

#variable 'imports'
pd="echo PROJECT_DIR=`$ENVCMD PROJECT_DIR remote`"
pf="echo PROJECT_FILES=`$ENVCMD PROJECT_FILES remote`"
nfs="echo NFS_SHARE=`$ENVCMD NFS_SHARE`"

if [ "$1" = "init" ]
then
    ./constructor.sh master.yaml init.skeleton.yaml \
		     <($pd) \
		     <($pf) \
      		     <($nfs) \
		     global.env \
		     discovery.url.tmp \
		     id.init.env \
		     init.env
elif [ "$1" = "compute"    ]
then
    ./constructor.sh master.yaml compute.skeleton.yaml <($pd) global.env discovery.url.tmp compute.env
else echo "choose configuration"
exit 1
fi
