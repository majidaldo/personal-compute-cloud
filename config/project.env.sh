#!/bin/bash

# input the env var for the first arg. then optionally
# specify remote|local pathing for the second arg

thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $thisdir


ld=$(echo ${thisdir}/project_dir.env.sh local)
echo PROJECT_DIR=$ld >  ${thisdir}/local-project_dir.env.tmp

rd=$(echo ${thisdir}/project_dir.env.sh remote)
echo PROJECT_DIR=$rd > ${thisdir}/remote-project_dir.env.tmp


rorl=${2-remote} #local is the other option


#cool syntax:  cmdthattakesfilearg <( cmdthatprints )
source <(./compose_env.sh \
	   <(echo PROJECT_DIR=$(./project_dir.env.sh $rorl)) \
	   project.env \
	   coreos/global.env \
   )


eval echo \$$1
