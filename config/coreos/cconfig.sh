#!/bin/sh

scriptDIR=$(dirname $0)
cd $scriptDIR

if [ "$1" = "init" ]
then
    ./constructor.sh master.yaml init.skeleton.yaml global.env discovery.url.tmp id.init.env init.env
elif [ "$1" = "compute"    ]
then
    ./constructor.sh master.yaml compute.skeleton.yaml global.env discovery.url.tmp compute.env
else echo "choose configuration"
exit 1
fi
