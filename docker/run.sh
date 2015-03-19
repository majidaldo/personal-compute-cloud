#!/bin/sh


docker run \
       -t -i \
       --privileged \
       --volume /tsad:/tsad \ # to get local sources
       mydind # my docker in docker
