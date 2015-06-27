#!/bin/sh
set -e


#args
VAGRANTFILE_IN="$1"
#BOX_NAME=
BOXPATH_OUT="$2"
#BOXPATH_OUT=nopth
BOX_FN=$(basename "${BOXPATH_OUT}")
BOX_DIR=$(dirname "${BOXPATH_OUT}")

VAGRANTFILE_DIR=$(dirname "${VAGRANTFILE_IN}")


cd $VAGRANTFILE_DIR
#env variable for vagrant. NOT a path!!
VAGRANT_VAGRANTFILE=$(basename ${VAGRANTFILE_IN})

VAGRANT_VAGRANTFILE=${VAGRANT_VAGRANTFILE} vagrant up #$BOX_NAME ...etc.

#rm -f ${BOX_FN}.tmp #ignores if not exists
shift 2
#BOXPATH_OUT with package does not work in cygwin!!!
VAGRANT_VAGRANTFILE=${VAGRANT_VAGRANTFILE} vagrant package \
	--vagrantfile ${VAGRANT_VAGRANTFILE} \
	--output ${BOXPATH_OUT} \
	"$@"
#last args are for --include option


#mv -f ${BOX_FN}.tmp $BOXPATH_OUT

VAGRANT_VAGRANTFILE=${VAGRANT_VAGRANTFILE} vagrant destroy -f
