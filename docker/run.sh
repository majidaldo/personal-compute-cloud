#!/bin/sh


#this is for interactive/dev use?

docker run \
       -t -i \
       --privileged \
       --volume /tsad-proj:/tsad-proj \
       --env-file /tsad-proj/tsad-sys/env \
       mydind # my docker in docker

#volume main purpose is for pushing code in from host for dev
#GPU access pt could go in the run cmd
