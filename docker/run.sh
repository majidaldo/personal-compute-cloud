#!/bin/sh


docker run \
       -t -i \
       --privileged \ 
       --volume /tsad-proj:/tsad-proj \
       mydind # my docker in docker

