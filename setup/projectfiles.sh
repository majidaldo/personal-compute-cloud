#!/bin/sh

source ../common.src
cd $SCRIPT_DIR


./vagrant up  --no-provision


./vagrant provision --provision-with \
	  "docker registry img creation"

if [ `$ENVCMD CREATE_VARLIBDOCKER_INSETUP` = true ]
then
    ./vagrant provision --provision-with \
	      "btrfs f/s creation for /var/lib/docker"
fi

./vagrant destroy -f

