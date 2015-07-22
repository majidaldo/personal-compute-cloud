#!/bin/sh

scriptDIR=$(dirname $0)
cd $scriptDIR

if [ "$1" = "init" ]
then
    echo -n "DISCOVERY_URL=" > discovery.url
    curl -w "\n" 'https://discovery.etcd.io/new?size=1' >> discovery.url
    ./constructor.sh master.yaml init.skeleton.yaml global.env discovery.url id.init.env init.env
elif [ "$1" = "compute_local"    ]
then
    ./constructor.sh master.yaml compute.skeleton.yaml global.env discovery.url compute.env
else echo "choose configuration"
exit 1
fi
