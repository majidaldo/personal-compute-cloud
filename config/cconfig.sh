#!/bin/sh

scriptDIR=$(dirname $0)
cd $scriptDIR


if [ "$1" = "init" ]
then
    ./constructor.sh master.yaml init.skeleton.yaml id.init.env init.env
#elif [     ]
else echo "choose configuration"
fi
