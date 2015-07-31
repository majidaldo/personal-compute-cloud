#!/bin/sh

#b/c the dir structure exits in the local machine
#..and the 'remote' (rooted) machine with different paths
# 

thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $thisdir

PROJECT_DIR_REL=$thisdir/../
source ./project.env
PROJECT_DIR_ROOT=${2-${PROJECT_DIR_ROOT}}




pthtype=${1-notgiven}

if [ $pthtype = "remote" ]
then
    PROJECT_DIR=${PROJECT_DIR_ROOT-$3}
    PROJECT_DIR=`echo $PROJECT_DIR | sed 's/~/\/home\/core\//'`
elif [ $pthtype = "local" ]
then
    PROJECT_DIR=$PROJECT_DIR_REL
else
    echo "provide 'local' or 'remote' path as first arg.\
 second arg can be the remote project root path"
    exit 1
fi


echo $PROJECT_DIR
