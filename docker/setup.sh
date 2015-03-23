#!/bin/sh

#1. build docker in docker
#2. enter the docker 
#3. build dockers (can it be done from this script?)

#todo: possible to output the container id to give it to another cmd?
docker build -t mydind dind/

