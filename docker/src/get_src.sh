#!/bin/sh

#if first arg is dev, gets it from local folder

SRCSRC=$1

#dev mode gets files from mounted dir
if [ "$SRCSRC" = "dev" ]
then
    ln -s /tsad-proj /src
#otherwise get them from the repo
else
    git clone https://github.com/majidaldo/tsad.git
    mv tsad /src 
fi

