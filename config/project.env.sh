#!/bin/bash
set -e

if [ "$1" == "--help" ]
then
    hm="input the env var for the first arg. then optionally \
     specify remote|local pathing for the second arg \
     if you specify the second arg, then the 3rd would be \
     optionally the root directory of the project"
    echo $hm
    exit
fi


if [ "$2" != "remote" ]
then
    if [ "$3" != "" ]
    then
	echo "must have 'remote' as the arg before $3."
	exit 1
    fi
fi

rorl=${2-local}
if [ "$rorl" != "local" ] && [ "$rorl" != "remote" ];
then
    echo "supply either local or remote as second arg"
    exit 1
fi

thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $thisdir

touch .private
#cool syntax:  cmdthattakesfilearg <( cmdthatprints )
#..but  the following only works in bash
source <(./compose_env.sh \
	   .private \
	   <(echo PROJECT_DIR=$(./project_dir.env.sh $rorl $3 )) \
	   project.env \
	   coreos/global.env \
   )


eval echo \$$1



