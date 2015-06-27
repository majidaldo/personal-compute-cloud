#!/bin/sh

#wrapper to get to vagrant dynamic inventory

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


vagrantfile_dir=${SCRIPTPATH}/../../.vagrant
vagrantinventory_dir=${SCRIPTPATH}/../vagrant
vagrantinventory=${vagrantinventory_dir}/vagrant.py

vagrantfile_fn=Vagrantfile
vagrantfile_pth=${vagrantfile_dir}/${vagrantfile_fn}
if [ ! -f ${vagrantfile_pth} ]; then
    #echo "File not found!"
    touch ${vagrantfile_pth}
fi


cd $vagrantfile_dir
#passing all params to vagrant inventory script
$vagrantinventory $*
