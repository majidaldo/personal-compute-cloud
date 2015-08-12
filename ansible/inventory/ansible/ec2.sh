#!/bin/sh

cd $(dirname $0)
source ../../../common.src



export AWS_ACCESS_KEY_ID=`$ENVCMD AWS_ACCESS_KEY_ID`
export AWS_SECRET_ACCESS_KEY=`$ENVCMD AWS_SECRET_ACCESS_KEY`

echo 

cd ../aws
./ec2.py $*

