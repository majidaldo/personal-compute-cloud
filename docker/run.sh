#!/bin/sh


#this is for interactive/dev use?

docker run \
       -t -i \
       --privileged \ 
       --volume /tsad-proj:/tsad-proj \
       mydind # my docker in docker

#GPU access pts could go here
